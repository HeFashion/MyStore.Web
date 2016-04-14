using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
namespace MyStore.App.ViewModels
{
    public class OrderViewModel
    {
        public bool IsSelected { get; set; }
        [DisplayName("Mã")]
        public int OrderNumber { get; set; }

        public MyStore.App.Models.MyData.OrderStatus StatusId { get; set; }
        [DisplayName("Trạng Thái")]
        public string Status { get; set; }
        [DisplayName("Chuyển Tới")]
        public string Address { get; set; }
        [DisplayName("Ngày Tạo")]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy hh:mm}")]
        public DateTime DateCreated { get; set; }
        [DisplayName("Mã Bưu Kiện")]
        public string ShippingCode { get; set; }
        [DisplayName("Ngày Gửi Hàng")]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        public DateTime? ShippingDate { get; set; }
        [DisplayName("Điện Thoại")]
        public string PhoneNumber { get; set; }
        [DisplayName("Tên Người Nhận")]
        public string ReceiverName { get; set; }
    }
}