using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Configuration;

using MyStore.App.Utilities;
using System.Threading.Tasks;

namespace MyStore.App.Utilities
{
    public class MailMananager
    {
        private static MailMananager _instance;
        public static MailMananager GetInstance()
        {
            if (_instance == null)
                _instance = new MailMananager();
            return _instance;
        }

        public SmtpClient GetClient()
        {
            string sendEmail = ConfigurationManager.AppSettings[GeneralContanstClass.PAGE_EMAIL];
            if (string.IsNullOrEmpty(sendEmail)) return null;
            SmtpClient result = new SmtpClient("hevaisoi.com", 25);
            result.Credentials = new NetworkCredential(sendEmail, "zF~s51q8");
            return result;
        }

        /*
        public MailMessage GetOrderMessage(int OrderId)
        {
            string sendEmail = ConfigurationManager.AppSettings[GeneralContanstClass.PAGE_EMAIL];
            if (string.IsNullOrEmpty(sendEmail)) return null;

            string receiveEmail = ConfigurationManager.AppSettings[GeneralContanstClass.RECEIVE_ORDER_EMAIL];
            MailMessage message = new MailMessage();

            message.From = new MailAddress(sendEmail);

            message.To.Add(receiveEmail);

            message.Subject = string.Format("Order {0} was created in {1}", OrderId, DateTime.Now);

            message.Body = "<b>New order was created:</b>" +

                            "<br/><br>Please! Check your system now";



            message.IsBodyHtml = true;

            message.Priority = MailPriority.High;

            return message;
        }
         */

        public async Task SendPasswordConfirmationEmail(string recieverEmail, string confirmationToken)
        {

            string sendEmail = ConfigurationManager.AppSettings[GeneralContanstClass.PAGE_EMAIL];
            if (string.IsNullOrEmpty(sendEmail)) return;

            using (var outClient = GetClient())
            {
                var urlHelper = new System.Web.Mvc.UrlHelper(HttpContext.Current.Request.RequestContext);

                MailMessage message = new MailMessage();
                message.From = new MailAddress(sendEmail);
                message.To.Add(recieverEmail);
                message.Subject = "HeVaiSoi - Kích hoạt tài khoản";
                string mailBody = System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath("~/EmailTemplates/PasswordConfirmationTemplate.htm"));
                mailBody = mailBody.Replace("#PasswordConfirmation",
                                            urlHelper.Action("RegisterConfirmation",
                                                             "Account",
                                                             new { @id = confirmationToken },
                                                             "http"));
                message.Body = mailBody;

                message.IsBodyHtml = true;
                message.Priority = MailPriority.High;

                await outClient.SendMailAsync(message);
            }
        }
        public async Task SendPasswordResetEmail(string recieverEmail, string confirmationToken)
        {

            string sendEmail = ConfigurationManager.AppSettings[GeneralContanstClass.PAGE_EMAIL];
            if (string.IsNullOrEmpty(sendEmail)) return;

            using (var outClient = GetClient())
            {
                var urlHelper = new System.Web.Mvc.UrlHelper(HttpContext.Current.Request.RequestContext);

                MailMessage message = new MailMessage();
                message.From = new MailAddress(sendEmail);
                message.To.Add(recieverEmail);
                message.Subject = "HeVaiSoi - Khôi Phục Mật Khẩu";
                string mailBody = System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath("~/EmailTemplates/PasswordResetTemplate.htm"));
                mailBody = mailBody.Replace("#PasswordReset",
                                            urlHelper.Action("PasswordRecoveryConfirm",
                                                             "Account",
                                                             new { @id = confirmationToken },
                                                             "http"));
                message.Body = mailBody;

                message.IsBodyHtml = true;
                message.Priority = MailPriority.High;

                await outClient.SendMailAsync(message);
            }
        }
    }
}