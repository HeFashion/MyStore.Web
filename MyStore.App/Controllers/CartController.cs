using MyStore.App.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using MyStore.App.ViewModels;
using MyStore.App.Models;

namespace MyStore.App.Controllers
{
    public class CartController : Controller
    {
        /*
        MyStore.App.Models.MyData.MyStoreEntities db;
        public CartController()
        {
            db = new Models.MyData.MyStoreEntities();
        }
        protected override void Dispose(bool disposing)
        {
            if (db != null)
                db.Dispose();
            base.Dispose(disposing);

        }
        */
        /// <summary>
        /// Add a product to Cart
        /// </summary>
        /// <param name="proId">product's Id</param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult AddToCart(int productId, double? productQuantity)
        {
            try
            {
                Guid cartId = CartHelper.GetCartId(this.HttpContext);
                CartHelper.AddItem(cartId, productId, productQuantity);
                return Json(new { status = true });
            }
            catch (Exception)
            {
                return Json(new { status = false });
            }
        }

        //
        // GET: /Cart/
        public ActionResult Index(string returnUrl)
        {
            ViewBag.BreadCrumbActive = "Giỏ Hàng";
            ViewBag.ReturnUrl = returnUrl;
            Guid cartId = CartHelper.GetCartId(this.HttpContext);
            return View("ShoppingCart", CartHelper.GetCartDetails(cartId));
        }

        /// <summary>
        /// Remove item from Cart
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Remove(int prodId)
        {
            Guid cartId = CartHelper.GetCartId(this.HttpContext);
            bool result = CartHelper.RemoveItem(cartId, prodId);
            if (!result) return HttpNotFound();

            return Index(string.Empty);
        }

        /// <summary>
        /// Change quantity of Cart item when use changed on ShoppingCart
        /// </summary>
        /// <param name="id"></param>
        /// <param name="qty"></param>
        /// <returns></returns>
        public ActionResult ChangeQuantity(int id, double qty)
        {
            Guid cartId = CartHelper.GetCartId(this.HttpContext);
            bool result = CartHelper.ChangeQuantity(cartId, id, qty);
            if (!result) return HttpNotFound();

            return PartialView("_CartTablePartial", CartHelper.GetCartDetails(cartId));
        }

        #region Private Functions


        #endregion
    }
}
