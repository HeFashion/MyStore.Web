using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyStore.App.ViewModels
{
    public class BreadCrumbViewModel
    {
        public bool IsActive { get; set; }
        public string Name { get; set; }
        public string Url { get; set; }
    }
}