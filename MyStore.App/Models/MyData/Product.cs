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
    
    public partial class Product
    {
        public Product()
        {
            this.Order_Items = new HashSet<Order_Items>();
        }
    
        public int product_id { get; set; }
        public int product_type_id { get; set; }
        public string product_name { get; set; }
        public int product_uom_id { get; set; }
        public string product_description { get; set; }
        public Nullable<decimal> product_price { get; set; }
        public string product_color { get; set; }
        public string product_size { get; set; }
        public string product_image { get; set; }
        public Nullable<System.DateTime> product_created_date { get; set; }
        public Nullable<double> product_quantity { get; set; }
        public string other_detail { get; set; }
        public Nullable<int> total_vote_score { get; set; }
        public Nullable<int> total_vote_count { get; set; }
        public Nullable<bool> product_recommend { get; set; }
    
        public virtual ICollection<Order_Items> Order_Items { get; set; }
        public virtual Ref_Product_Type Ref_Product_Type { get; set; }
        public virtual Unit_Of_Measure Unit_Of_Measure { get; set; }
    }
}
