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
    
    public partial class Blog
    {
        public int blog_id { get; set; }
        public string blog_title { get; set; }
        public string blog_content { get; set; }
        public string blog_description { get; set; }
        public Nullable<System.DateTime> blog_date_create { get; set; }
        public Nullable<int> blog_total_vote { get; set; }
        public Nullable<int> blog_total_score { get; set; }
        public string blog_img_title { get; set; }
    }
}