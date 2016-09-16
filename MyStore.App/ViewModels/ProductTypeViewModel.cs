using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyStore.App.ViewModels
{
    public class ProductTypeViewModel
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Image { get; set; }
    }
}