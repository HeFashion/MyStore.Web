using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net.Mail;
using System.Net;
using System.Diagnostics;

using WebMatrix.WebData;

using MyStore.App.ViewModels;
using MyStore.App.Models;
using MyStore.App.Models.MyData;
using MyStore.App.Utilities;
using System.Threading;
using MyStore.App.Filters;
using System.Threading.Tasks;

namespace MyStore.App.Controllers
{
    public class CheckoutController : Controller
    {

        #region Private
        private static readonly string CHECKOUT_SESSION_KEY = "CHECKOUT";

        private void ModelErrorClear(ModelStateDictionary modelState)
        {
            foreach (var item in modelState.Values)
            {
                item.Errors.Clear();
            }
        }
        /*
        private void SendMail(int orderId)
        {
            MailMananager mailManager = MailMananager.GetInstance();
            SmtpClient client = mailManager.GetClient();
            client.SendCompleted += client_SendCompleted;
            MailMessage message = mailManager.GetOrderMessage(orderId);
            client.Send(message);
            
        }

        private void client_SendCompleted(object sender, System.ComponentModel.AsyncCompletedEventArgs e)
        {
            string sSource = "Shopper";
            string sLog = string.Empty; ;
            string sEvent = "Email Send Completed";

            bool isWrite = false;
            MailMessage msg = e.UserState as MailMessage;
            if (e.Cancelled)
            {
                sLog = "Email is cancelled";
                isWrite = true;
            }

            if (e.Error != null)
            {
                sLog = e.Error.ToString();
                isWrite = true;
            }

            if (isWrite)
            {
                Trace.
                if (!EventLog.SourceExists(sSource))
                    EventLog.CreateEventSource(sSource, sLog);

                EventLog.WriteEntry(sSource, sEvent);
                EventLog.WriteEntry(sSource, sEvent,
                    EventLogEntryType.Warning, 234);
            }
            if (msg != null)
                msg.Dispose();
        }
*/
        private void SetBreadCrumbs()
        {
            IDictionary<string, string> dCrumbs = new Dictionary<string, string>();
            dCrumbs.Add("Thanh Toán", string.Empty);
            ViewData["BreadCrumbs"] = dCrumbs;
        }

        private void CreateOrder(CheckoutViewModel model)
        {
            int newOrderId = 0;

            using (MyStoreEntities db = new MyStoreEntities())
            {
                Order newOrder = new Order();
                newOrder.Order_Status_Codes = db.Order_Status_Codes.Where(p => p.order_status_description == "New").SingleOrDefault();
                newOrder.date_order_placed = DateTime.Now;

                if (model.IsPassword)
                    newOrder.user_id = WebSecurity.CurrentUserId;
                else
                    newOrder.email_address = model.UserName;
                newOrder.receipter_name = model.CustomerName;
                newOrder.order_address = model.OrderAddress;
                newOrder.phone_number = model.PhoneNumber;
                newOrder.order_description = model.OrderDescription;
                var cartDetailsList = CartHelper.GetCartDetail(this.HttpContext);
                if (cartDetailsList != null)
                {
                    foreach (var item in cartDetailsList)
                    {
                        Order_Items newItem = new Order_Items();
                        var inventory = db.Products.Where(p => p.product_id == item.ProductId)
                                                   .Select(p => p.product_quantity)
                                                   .SingleOrDefault();
                        if (inventory < item.TotalQuantity)
                            newItem.Ref_Order_Item_Status_Codes = db.Ref_Order_Item_Status_Codes.Where(p => p.order_item_status_description == "Out Of Stock")
                                                                                                .SingleOrDefault();
                        else
                            newItem.Ref_Order_Item_Status_Codes = db.Ref_Order_Item_Status_Codes.Where(p => p.order_item_status_description == "Normal")
                                                                                                .SingleOrDefault();
                        newItem.product_id = item.ProductId;
                        newItem.order_item_quantity = item.TotalQuantity;
                        newItem.order_item_amount = item.TotalAmount;
                        newOrder.Order_Items.Add(newItem);
                    }
                }

                db.Orders.Add(newOrder);
                db.SaveChanges();
                newOrderId = newOrder.order_id;
            }
            //Send mail to Web's Owner
            //SendMail(newOrderId);

            this.Session[CHECKOUT_SESSION_KEY] = null;
            Utilities.CartHelper.EmptyCart(this.HttpContext);
        }

        #endregion

        //
        // GET: /Checkout/
        [CheckShoppingCart]
        [InitializeSimpleMembership]
        public ActionResult Index()
        {
            CheckoutViewModel checkoutObj = this.Session[CHECKOUT_SESSION_KEY] as CheckoutViewModel;

            if (checkoutObj == null)
            {
                checkoutObj = new ViewModels.CheckoutViewModel();
                checkoutObj.IsPassword = true;
                if (!Request.IsAuthenticated)
                {
                    checkoutObj.CurrentStep = ViewModels.CheckoutStep.Authentication;
                }
                else
                {
                    checkoutObj.CurrentStep = ViewModels.CheckoutStep.BillingInfo;
                    checkoutObj.IsPassword = true;
                    checkoutObj.UserName = User.Identity.Name;

                    this.Session[CHECKOUT_SESSION_KEY] = checkoutObj;
                }

            }
            else
            {
                checkoutObj.CurrentStep = Request.IsAuthenticated ? ViewModels.CheckoutStep.BillingInfo : ViewModels.CheckoutStep.Authentication;
            }
            SetBreadCrumbs();
            return View("Index", checkoutObj);
        }

        [HttpPost]
        [CheckShoppingCart]
        [ValidateAntiForgeryToken]
        [InitializeSimpleMembership]
        public ActionResult AuthenticationMethod(CheckoutViewModel viewModel)
        {
            ViewBag.BreadCrumbActive = "Tính Tiền";
            ModelErrorClear(ModelState);
            if (ModelState.IsValidField("UserName"))
            {
                if (viewModel.IsPassword)
                {
                    if (string.IsNullOrEmpty(viewModel.Password))
                    {
                        ModelState.AddModelError("Password", "Vui lòng nhập Password");
                    }
                    else
                    {
                        if (WebSecurity.Login(viewModel.UserName, viewModel.Password))
                        {
                            viewModel.CurrentStep = CheckoutStep.BillingInfo;
                        }
                        else
                            ModelState.AddModelError("Password", "Password không đúng");
                    }
                }
                else
                {
                    viewModel.CurrentStep = CheckoutStep.BillingInfo;
                }

            }
            this.Session[CHECKOUT_SESSION_KEY] = viewModel;

            SetBreadCrumbs();
            return View("Index", viewModel);
        }

        [HttpPost]
        [CheckShoppingCart]
        [InitializeSimpleMembership]
        public async Task<ActionResult> DeliveryInformation(CheckoutViewModel viewModel)
        {
            if (ModelState.IsValidField("CustomerName") &&
                ModelState.IsValidField("OrderAddress") &&
                ModelState.IsValidField("PhoneNumber"))
            {
                ModelErrorClear(ModelState);

                CheckoutViewModel model = this.Session[CHECKOUT_SESSION_KEY] as CheckoutViewModel;
                if (model != null)
                {
                    model.CurrentStep = CheckoutStep.PaymentInfo;
                    model.CustomerName = viewModel.CustomerName;
                    model.OrderAddress = viewModel.OrderAddress;
                    model.PhoneNumber = viewModel.PhoneNumber;
                    model.OrderDescription = viewModel.OrderDescription;

                    this.Session[CHECKOUT_SESSION_KEY] = model;
                    if (model.CurrentStep != CheckoutStep.PaymentInfo)
                    {
                        return Index();
                    }
                    else
                    {
                        this.CreateOrder(model);
                        await MailMananager.GetInstance()
                                           .SendCheckoutCompletedEmail("hoanhdn2004@gmail.com",
                                                                       "thanhgiang9229@gmail.com");
                        return View("CheckoutCompleted");
                    }

                }
                else
                    return Index();

            }

            viewModel.CurrentStep = CheckoutStep.BillingInfo;
            SetBreadCrumbs();
            return View("Index", viewModel);
        }

    }
}
