using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using DotNetOpenAuth.AspNet;
using Microsoft.Web.WebPages.OAuth;
using WebMatrix.WebData;
using MyStore.App.Filters;

using MyStore.App.Models.Authentication;
using DotNetOpenAuth.GoogleOAuth2;
using MyStore.App.Utilities;
using System.Threading.Tasks;

namespace MyStore.App.Controllers
{
    [Authorize]
    [InitializeSimpleMembership]
    public class AccountController : Controller
    {
        //
        // GET: /Account/Login

        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            ViewBag.IsRecovery = false;
            return View();
        }

        //
        // POST: /Account/Login

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginModel model, string returnUrl)
        {
            bool isRecovery = false;
            if (ModelState.IsValid)
            {
                if (WebSecurity.IsConfirmed(model.UserName) &&
                    WebSecurity.Login(model.UserName, model.Password, persistCookie: model.RememberMe))
                {
                    if (Roles.IsUserInRole(model.UserName, "Admin"))
                    {
                        return RedirectToAction("Index", "Admin");
                    }
                    else
                    {
                        return RedirectToLocal(returnUrl);
                    }
                }
                isRecovery = true;
            }
            ViewBag.IsRecovery = isRecovery;
            // If we got this far, something failed, redisplay form
            ModelState.AddModelError("", "Tài khoản hoặc mật khẩu không đúng.");
            return View(model);
        }

        //
        // POST: /Account/LogOff

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LogOff()
        {
            WebSecurity.Logout();

            return RedirectToAction("Index", "Home");
        }

        //
        // GET: /Account/Register

        [AllowAnonymous]
        public ActionResult Register()
        {
            return View();
        }

        //
        // POST: /Account/Register

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Register(RegisterModel model)
        {
            if (ModelState.IsValid)
            {
                // Attempt to register the user
                try
                {
                    string confirmationToken = WebSecurity.CreateUserAndAccount(model.UserName,
                                                                                model.Password,
                                                                                new { EmailAddress = model.UserName },
                                                                                true);
                    Roles.AddUserToRole(model.UserName, "User");
                    await MailMananager.GetInstance()
                                       .SendPasswordConfirmationEmail(model.UserName, confirmationToken);
                    ViewBag.Title = "Xác Nhận Email Của Quý Khách";
                    ViewBag.Message = string.Format("<p>Một email xác nhận đã được gửi tới <strong>{0}</strong>, quý khách vui lòng truy cập vào email và làm theo hướng dẫn để kích hoạt tài khoản.</p>", model.UserName);
                    return View("RegisterConfirmation");
                }
                catch (MembershipCreateUserException e)
                {
                    ModelState.AddModelError("", ErrorCodeToString(e.StatusCode));
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        [AllowAnonymous]
        public ActionResult RegisterConfirmation(string id)
        {
            ViewBag.Title = "Xin Chào Quý Khách";

            if (WebSecurity.ConfirmAccount(id))
            {
                ViewBag.Message = string.Format("<p>Chào mừng bạn đến với Website của chúng tôi.<br />Bấm vào <a href='{0}'>đây</a> để đăng nhập ngay.</p>", Url.Action("Login"));
            }
            else
                ViewBag.Message = string.Format("Không thể xác minh mã kích hoạt.<br />Bấm vào <a href='{0}'>đây</a> để quay lại trang chủ.</p>", Url.Action("Index", "Home"));

            return View("RegisterConfirmation");
        }

        //
        // POST: /Account/Disassociate
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Disassociate(string provider, string providerUserId)
        {
            string ownerAccount = OAuthWebSecurity.GetUserName(provider, providerUserId);
            ManageMessageId? message = null;

            // Only disassociate the account if the currently logged in user is the owner
            if (ownerAccount == User.Identity.Name)
            {
                // Use a transaction to prevent the user from deleting their last login credential
                using (var scope = new TransactionScope(TransactionScopeOption.Required, new TransactionOptions { IsolationLevel = IsolationLevel.Serializable }))
                {
                    bool hasLocalAccount = OAuthWebSecurity.HasLocalAccount(WebSecurity.GetUserId(User.Identity.Name));
                    if (hasLocalAccount || OAuthWebSecurity.GetAccountsFromUserName(User.Identity.Name).Count > 1)
                    {
                        OAuthWebSecurity.DeleteAccount(provider, providerUserId);
                        scope.Complete();
                        message = ManageMessageId.RemoveLoginSuccess;
                    }
                }
            }

            return RedirectToAction("Manage", new { Message = message });
        }

        //
        // GET: /Account/Manage

        public ActionResult Manage(ManageMessageId? message)
        {
            ViewBag.StatusMessage =
            message == ManageMessageId.ChangePasswordSuccess ? "Mật khẩu của quý khách đã được thay đổi."
            : message == ManageMessageId.SetPasswordSuccess ? "Mật khẩu đã được thiết lập."
            : message == ManageMessageId.RemoveLoginSuccess ? "Tài khoản xã hội đã được xoá."
            : "";

            ViewBag.HasLocalPassword = OAuthWebSecurity.HasLocalAccount(WebSecurity.GetUserId(User.Identity.Name));
            ViewBag.ReturnUrl = Url.Action("Manage");
            ViewBag.UserName = User.Identity.Name;
            return PartialView("_ManageAccountPartial");
            //return View();
        }

        //
        // POST: /Account/Manage

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Manage(LocalPasswordModel model)
        {
            bool hasLocalAccount = OAuthWebSecurity.HasLocalAccount(WebSecurity.GetUserId(User.Identity.Name));
            ViewBag.HasLocalPassword = hasLocalAccount;
            ViewBag.ReturnUrl = Url.Action("Manage");
            if (hasLocalAccount)
            {
                if (ModelState.IsValid)
                {
                    // ChangePassword will throw an exception rather than return false in certain failure scenarios.
                    bool changePasswordSucceeded;
                    try
                    {
                        changePasswordSucceeded = WebSecurity.ChangePassword(User.Identity.Name, model.OldPassword, model.NewPassword);
                    }
                    catch (Exception)
                    {
                        changePasswordSucceeded = false;
                    }

                    if (changePasswordSucceeded)
                    {
                        return RedirectToAction("Manage", new { Message = ManageMessageId.ChangePasswordSuccess });
                    }
                    else
                    {
                        ModelState.AddModelError("", "Nhập mật khẩu cũ sai hoặc mật khẩu mới không khớp.");
                    }
                }
            }
            else
            {
                // User does not have a local password so remove any validation errors caused by a missing
                // OldPassword field
                ModelState state = ModelState["OldPassword"];
                if (state != null)
                {
                    state.Errors.Clear();
                }

                if (ModelState.IsValid)
                {
                    try
                    {
                        WebSecurity.CreateAccount(User.Identity.Name, model.NewPassword);
                        return RedirectToAction("Manage", new { Message = ManageMessageId.SetPasswordSuccess });
                    }
                    catch (Exception)
                    {
                        ModelState.AddModelError("", String.Format("Tên \"{0}\" đã có người sử dụng. Vui lòng chọn tên khác.", User.Identity.Name));
                    }
                }
            }

            // If we got this far, something failed, redisplay form
            //return View(model);
            ViewBag.UserName = User.Identity.Name;
            return PartialView("_ManageAccountPartial", model);
        }

        //
        // POST: /Account/ExternalLogin

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult ExternalLogin(string provider, string returnUrl)
        {
            return new ExternalLoginResult(provider, Url.Action("ExternalLoginCallback", new { ReturnUrl = returnUrl }));
        }

        //
        // GET: /Account/ExternalLoginCallback
        [AllowAnonymous]
        public ActionResult ExternalLoginCallback(string returnUrl)
        {
            GoogleOAuth2Client.RewriteRequest();

            AuthenticationResult result = OAuthWebSecurity.VerifyAuthentication(Url.Action("ExternalLoginCallback", new { ReturnUrl = returnUrl }));
            if (!result.IsSuccessful)
            {
                return RedirectToAction("ExternalLoginFailure");
            }

            if (OAuthWebSecurity.Login(result.Provider, result.ProviderUserId, createPersistentCookie: false))
            {
                return RedirectToLocal(returnUrl);
            }

            if (User.Identity.IsAuthenticated)
            {
                // If the current user is logged in add the new account
                OAuthWebSecurity.CreateOrUpdateAccount(result.Provider, result.ProviderUserId, User.Identity.Name);
                return RedirectToLocal(returnUrl);
            }
            else
            {
                SaveAccessToken(result);

                // User is new, ask for their desired membership name
                string loginData = OAuthWebSecurity.SerializeProviderUserId(result.Provider, result.ProviderUserId);
                ViewBag.ProviderDisplayName = OAuthWebSecurity.GetOAuthClientData(result.Provider).DisplayName;
                ViewBag.ReturnUrl = returnUrl;
                string strEmail = string.Empty;
                bool isVerified = false;
                GetExtraData(result, out strEmail, out isVerified);

                return View("ExternalLoginConfirmation", new RegisterExternalLoginModel
                {
                    UserName = result.UserName,
                    ExternalLoginData = loginData,
                    FullName = result.ExtraData.ContainsKey("name") ? result.ExtraData["name"] : "Không có",
                    Email = !string.IsNullOrEmpty(strEmail) ? strEmail : "Không có",
                    Verified = isVerified
                });
            }
        }

        private void SaveAccessToken(AuthenticationResult result)
        {
            if (result == null) return;
            if (result.ExtraData.ContainsKey("accesstoken"))
            {
                string providerName = result.Provider.ToLower();
                if (providerName == "facebook")
                {
                    Session[GeneralContanstClass.FACEBOOK_SESSION_KEY] = result.ExtraData["accesstoken"];
                }
                else if (providerName == "google")
                {
                    Session[GeneralContanstClass.GOOGLE_SESSION_KEY] = result.ExtraData["accesstoken"];
                }
            }
        }
        private void GetExtraData(AuthenticationResult result, out string email, out bool isVerified)
        {
            email = string.Empty;
            isVerified = false;

            if (result == null)
            {
                return;
            }
            string providerName = result.Provider.ToLower();

            if (providerName == "facebook")
            {
                Facebook.FacebookClient fbClient = new Facebook.FacebookClient(Convert.ToString(Session[GeneralContanstClass.FACEBOOK_SESSION_KEY]));
                dynamic me = fbClient.Get("me", new { fields = "email,location,verified" });
                email = me.email;
                isVerified = Convert.ToBoolean(me.verified);
            }
            else if (providerName == "google")
            {
                email = result.ExtraData.ContainsKey("email") ? result.ExtraData["email"] : string.Empty;
                isVerified = result.ExtraData.ContainsKey("email_verified") ? Convert.ToBoolean(result.ExtraData["email_virified"]) : false;
            }
        }
        //
        // POST: /Account/ExternalLoginConfirmation

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult ExternalLoginConfirmation(RegisterExternalLoginModel model, string returnUrl)
        {
            string provider = null;
            string providerUserId = null;

            if (User.Identity.IsAuthenticated || !OAuthWebSecurity.TryDeserializeProviderUserId(model.ExternalLoginData, out provider, out providerUserId))
            {
                return RedirectToAction("Manage");
            }

            if (ModelState.IsValid)
            {
                // Insert a new user into the database
                using (UsersContext db = new UsersContext())
                {
                    UserProfile user = db.UserProfiles.FirstOrDefault(u => u.UserName.ToLower() == model.UserName.ToLower());
                    // Check if user already exists
                    if (user == null)
                    {
                        // Insert name into the profile table
                        user = db.UserProfiles.Add(new UserProfile
                        {
                            UserName = model.UserName,
                            EmailAddress = model.Email,
                            FullName = model.FullName
                        });
                        db.SaveChanges();

                        ExternalUserInformation extUserInfo = new ExternalUserInformation
                        {
                            UserId = user.UserId,
                            FullName = model.FullName == "Không có" ? string.Empty : model.FullName,
                            Link = string.Empty,
                            Verified = model.Verified
                        };
                        db.ExternalUsers.Add(extUserInfo);
                        db.SaveChanges();

                        OAuthWebSecurity.CreateOrUpdateAccount(provider, providerUserId, model.UserName);

                        Roles.AddUserToRole(model.UserName, "User");//Add this user to default role

                        OAuthWebSecurity.Login(provider, providerUserId, createPersistentCookie: false);

                        return RedirectToLocal(returnUrl);
                    }
                    else
                    {
                        ModelState.AddModelError(string.Empty, "Tên hiển thị đã được sử dụng. Quý khách vui lòng chọn tên khác.");

                    }
                }
            }

            ViewBag.ProviderDisplayName = OAuthWebSecurity.GetOAuthClientData(provider).DisplayName;
            ViewBag.ReturnUrl = returnUrl;
            return View(model);
        }

        //
        // GET: /Account/ExternalLoginFailure

        [AllowAnonymous]
        public ActionResult ExternalLoginFailure()
        {
            return View();
        }

        [AllowAnonymous]
        [ChildActionOnly]
        public ActionResult ExternalLoginsList(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return PartialView("_ExternalLoginsListPartial", OAuthWebSecurity.RegisteredClientData);
        }

        [ChildActionOnly]
        public ActionResult RemoveExternalLogins()
        {
            ICollection<OAuthAccount> accounts = OAuthWebSecurity.GetAccountsFromUserName(User.Identity.Name);
            List<ExternalLogin> externalLogins = new List<ExternalLogin>();
            foreach (OAuthAccount account in accounts)
            {
                AuthenticationClientData clientData = OAuthWebSecurity.GetOAuthClientData(account.Provider);

                externalLogins.Add(new ExternalLogin
                {
                    Provider = account.Provider,
                    ProviderDisplayName = clientData.DisplayName,
                    ProviderUserId = account.ProviderUserId,
                });
            }

            ViewBag.ShowRemoveButton = externalLogins.Count > 1 || OAuthWebSecurity.HasLocalAccount(WebSecurity.GetUserId(User.Identity.Name));
            return PartialView("_RemoveExternalLoginsPartial", externalLogins);
        }

        [HttpGet]
        [AllowAnonymous]
        public ActionResult PasswordRecovery()
        {
            return View("PasswordRecovery");
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> PasswordRecoverySend(RecoveryModel model)
        {
            if (ModelState.IsValid)
            {
                if (WebSecurity.UserExists(model.UserName))
                {
                    string strToken = WebSecurity.GeneratePasswordResetToken(model.UserName, 2880);
                    await MailMananager.GetInstance()
                                       .SendPasswordResetEmail(model.UserName, strToken);
                    ViewBag.Title = "Xác Nhận Qua Email";
                    ViewBag.Message = string.Format("<p>Một email xác nhận đã được gửi tới <strong>{0}</strong>, quý khách vui lòng truy cập vào email và làm theo hướng dẫn để khôi phục mật khẩu.<br /> <strong>Lưu ý:</strong> Email chỉ có tác dụng trong vòng 2 ngày.</p>", model.UserName);
                    return View("RegisterConfirmation");
                }
            }
            return View("PasswordRecovery", model);
        }

        [HttpGet]
        [AllowAnonymous]
        public ActionResult PasswordRecoveryConfirm(string id)
        {
            if (string.IsNullOrEmpty(id) ||
                WebSecurity.GetUserIdFromPasswordResetToken(id) <= 0)
            {
                ViewBag.Title = "Không Thể Xác Nhận";
                ViewBag.Message = "<p>Không thể xác nhận mã khôi phục, quý khách vui lòng chọn <a href='/Account/PasswordRecovery'>Khôi Phục</a> để gửi lại mã khôi phục.</p>";
                return View("RegisterConfirmation");
            }
            RecoveryModelConfirmed model = new RecoveryModelConfirmed()
            {
                RecoveryToken = id
            };
            return View("PasswordRecoveryConfirm", model);
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult PasswordRecoveryAction(RecoveryModelConfirmed model)
        {
            if (ModelState.IsValid)
            {
                if (WebSecurity.ResetPassword(model.RecoveryToken, model.NewPassword))
                {
                    ViewBag.Title = "Mật Khẩu Đã Được Thay Đổi";
                    ViewBag.Message = string.Format("<p>Chào mừng quý khác quay lại Website của chúng tôi.<br />Bấm vào <a href='{0}'>Đăng Nhập</a> để đăng nhập ngay.</p>", Url.Action("Login"));

                    return View("RegisterConfirmation");
                }
                else
                {
                    ModelState.AddModelError("", "Mã khôi phục đã được sử dụng, hoặc đã hết hạn sử dụng");
                }
            }
            return View("PasswordRecoveryConfirm", model);
        }
        #region Helpers
        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        public enum ManageMessageId
        {
            ChangePasswordSuccess,
            SetPasswordSuccess,
            RemoveLoginSuccess,
        }

        internal class ExternalLoginResult : ActionResult
        {
            public ExternalLoginResult(string provider, string returnUrl)
            {
                Provider = provider;
                ReturnUrl = returnUrl;
            }

            public string Provider { get; private set; }
            public string ReturnUrl { get; private set; }

            public override void ExecuteResult(ControllerContext context)
            {
                OAuthWebSecurity.RequestAuthentication(Provider, ReturnUrl);
            }
        }

        private static string ErrorCodeToString(MembershipCreateStatus createStatus)
        {
            // See http://go.microsoft.com/fwlink/?LinkID=177550 for
            // a full list of status codes.
            switch (createStatus)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "Tên đã được sử dụng. Vui lòng, sử dụng tên khác.";

                case MembershipCreateStatus.DuplicateEmail:
                    return "Địa chỉ email đã được sử dụng. Vui lòng sử dụng địa chỉ email khác.";

                case MembershipCreateStatus.InvalidPassword:
                    return "Mật khẩu không đúng cách. Vui lòng nhập lại cho đúng.";

                case MembershipCreateStatus.InvalidEmail:
                    return "Email không đúng cách. Vui lòng kiểm tra và nhập lại cho đúng.";

                case MembershipCreateStatus.InvalidAnswer:
                    return "The password retrieval answer provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidUserName:
                    return "The user name provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.ProviderError:
                    return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                case MembershipCreateStatus.UserRejected:
                    return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }
        #endregion
    }
}
