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
    
    public partial class Cloth
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string ImgUrl { get; set; }
        public Nullable<decimal> Price { get; set; }
        public int CatalogueId { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
    
        public virtual ClothCatalog ClothCatalog { get; set; }
    }
}
