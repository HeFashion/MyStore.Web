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
    
    public partial class Vote
    {
        public int vote_id { get; set; }
        public VoteType vote_type { get; set; }
        public string ip_address { get; set; }
        public Nullable<int> vote_score { get; set; }
        public Nullable<int> vote_object_id { get; set; }
    }
}
