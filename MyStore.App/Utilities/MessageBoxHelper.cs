using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MyStore.App.Utilities
{
    public class MessageBoxHelper
    {
        private const string MessBox_Template = "<div class='modal-content'>" +
                                                    "<div class='modal-header'>" +
                                                        "<button type='button' class='close' data-dismiss='modal'>&times;</button>" +
                                                        "<h4 class='title text-center'>Thông Báo</h4>" +
                                                    "</div>" +
                                                    "<div class='modal-body text-center'>" +
                                                        "{0}" +
                                                    "</div>" +
                                                    "<div class='modal-footer'>" +
                                                        "<a class='btn btn-default get' data-dismiss='modal'>Đóng</a>" +
                                                    "</div>" +
                                                "</div>";

        public static string GetThanksMessage()
        {
            return string.Format(MessBox_Template, "Nhận xét của quý khách đã được ghi nhận");
        }

        public static string GetFailMessage()
        {
            return string.Format(MessBox_Template, "Đã xảy ra lỗi. Vui lòng thử lại sau");
        }

        public static string GetLoginMessage()
        {
            UrlHelper url = new UrlHelper(HttpContext.Current.Request.RequestContext);
            return string.Format(MessBox_Template, "Quý khách vui lòng <a href='" + url.Action("Login", "Account") + "'>đăng nhập</a> để sử dụng chức năng này.");
        }

        public static string GetVotedMessage()
        {
            return string.Format(MessBox_Template, "Quý khách đã từng cho điểm đối tượng này rồi.");
        }

        public static string GetExistedProductInCompare()
        {
            return string.Format(MessBox_Template, "Danh sách so sánh đã tồn tại sản phẩm này rồi.");
        }
    }
}