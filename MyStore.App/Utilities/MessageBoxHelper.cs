using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyStore.App.Utilities
{
    public class MessageBoxHelper
    {
        public static string GetThanksMessage()
        {
            return "<div class='modal-content'> <div class='modal-header'> <button type='button' class='close' data-dismiss='modal'>&times;</button> <h4 class='title text-center'>Nhận xét của bạn đã được ghi nhận</h4> </div>  <div class='modal-footer'> <a class='btn btn-default get' data-dismiss='modal'>Đóng</a> </div> </div>";
        }
        public static string GetFailMessage()
        {
            return "<div class='modal-content'> <div class='modal-header'> <button type='button' class='close' data-dismiss='modal'>&times;</button> <h4 class='title text-center'>Đã xảy ra lỗi. Vui lòng thử lại sau</h4> </div>  <div class='modal-footer'> <a class='btn btn-default get' data-dismiss='modal'>Đóng</a> </div> </div>";
        }
    }
}