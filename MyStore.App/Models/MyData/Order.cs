//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MyStore.App.Models.MyData
{
    using System;
    using System.Collections.Generic;
    
    public partial class Order
    {
        public Order()
        {
            this.Order_Items = new HashSet<Order_Items>();
        }
    
        public int order_id { get; set; }
        public Nullable<int> user_id { get; set; }
        public OrderStatus order_status_id { get; set; }
        public Nullable<System.DateTime> date_order_placed { get; set; }
        public string order_description { get; set; }
        public string receipter_name { get; set; }
        public string order_address { get; set; }
        public string phone_number { get; set; }
        public string email_address { get; set; }
        public Nullable<int> shipping_id { get; set; }
    
        public virtual ICollection<Order_Items> Order_Items { get; set; }
        public virtual Order_Status_Codes Order_Status_Codes { get; set; }
        public virtual Shipping_Bills Shipping_Bills { get; set; }
    }
}
