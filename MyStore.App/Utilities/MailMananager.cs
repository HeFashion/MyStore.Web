using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Configuration;

using MyStore.App.Utilities;

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
            SmtpClient result = new SmtpClient("smtp.gmail.com", 587);
            result.Credentials = new NetworkCredential(sendEmail, "!Hcchcc\"");
            result.EnableSsl = true;
            return result;
        }

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
    }
}