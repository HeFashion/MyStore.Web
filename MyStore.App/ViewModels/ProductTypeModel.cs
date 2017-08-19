using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace MyStore.App.ViewModels
{
    [DataContract]
    public class ProductTypeModel
    {
        [DataMember]
        public int TypeId { get; set; }
        [DataMember]
        public string TypeUrl { get; set; }
        [DataMember]
        public string TypeDesc { get; set; }
        [DataMember]
        public int TotalProduct { get; set; }
        [DataMember]
        public short TypeOrder { get; set; }

        public List<ProductTypeModel> ChildType { get; set; }
    }
}