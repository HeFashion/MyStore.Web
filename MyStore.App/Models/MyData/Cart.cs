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
    
    public partial class Cart
    {
        public Cart()
        {
            this.Cart_Items = new HashSet<Cart_Items>();
        }
    
        public System.Guid cart_id { get; set; }
        public Nullable<System.DateTime> cart_created_date { get; set; }
    
        public virtual ICollection<Cart_Items> Cart_Items { get; set; }
    }
}
