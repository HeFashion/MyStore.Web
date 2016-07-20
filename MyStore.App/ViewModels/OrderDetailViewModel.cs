using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyStore.App.ViewModels
{
    public class OrderDetailViewModel
    {
        public int ItemId { get; set; }
        public int ItemProductId { get; set; }
        public string ItemCode { get; set; }
        public string ItemUnit { get; set; }
        public decimal ItemPrice { get; set; }
        public double ItemQuantity { get; set; }
        public string ItemImage { get; set; }
        public decimal ItemTotalAmt { get; set; }
        public bool IsDelete { get; set; }
    }


}