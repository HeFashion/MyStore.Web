using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MyStore.App.Models.MyData;
using WebMatrix.WebData;
using MyStore.App.Filters;

namespace MyStore.App.Controllers
{
    public class OrderController : Controller
    {
        private MyStoreEntities db = new MyStoreEntities();
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }

        //
        // GET: /Order/
        [Authorize]
        [InitializeSimpleMembership]
        public ActionResult Index()
        {
            int userId = WebSecurity.CurrentUserId;

            var orders = db.Orders
                           .Where(order => order.user_id == userId)
                           .Include(o => o.Order_Status_Codes)
                           .Select(o => new MyStore.App.ViewModels.OrderViewModel()
                           {
                               OrderNumber = o.order_id,
                               Status = o.Order_Status_Codes.order_status_description,
                               Address = o.order_address,
                               DateCreated = o.date_order_placed ?? DateTime.Now,
                               StatusId = o.order_status_id,
                               PhoneNumber = o.phone_number,
                               ReceiverName = o.receipter_name
                           });
            return View(orders.ToList());
        }

        //
        // GET: /Order/Details/5
        [Authorize]
        public ActionResult Details(int id = 0)
        {
            var query = from o in db.Order_Items
                        join p in db.Products on o.product_id equals p.product_id
                        where o.order_id == id
                        select new MyStore.App.ViewModels.ShoppingCartViewModel()
                        {
                            Price = o.order_item_amount ?? 0,
                            ProductId = o.product_id,
                            ProductDescription = p.product_description,
                            ProductImage = p.product_image,
                            ProductName = p.product_name,
                            TotalQuantity = o.order_item_quantity
                        };

            return PartialView("_OrderDetailPartial", query.ToList());
        }

    }
}