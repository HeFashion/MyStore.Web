using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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
            return string.Format(MessBox_Template, "Quý khách vui lòng đăng nhập để sử dụng chức năng này.");
        }

        public static string GetVotedMessage()
        {
            return string.Format(MessBox_Template, "Quý khách đã từng cho điểm đối tượng này rồi.");
        }
    }
}