using MyStore.App.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MyStore.App.Controllers
{
    public class CartController : Controller
    {
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
                ViewModels.ShoppingCart cart = ViewModels.ShoppingCart.GetCart(this.HttpContext);
                bool result = cart.AddToCart(productId, productQuantity ?? 1);
                cart.SaveChanges(this.HttpContext);

                if (result)
                {
                    return Json(new { status = true });
                }
                else
                {
                    return Json(new { status = false });
                }
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
            return RedirectToAction("ShowCart", "Product", new { @returnUrl = returnUrl });
        }

        /// <summary>
        /// Remove item from Cart
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Remove(int id)
        {
            ViewModels.ShoppingCart cart = ViewModels.ShoppingCart.GetCart(this.HttpContext);
            bool result = cart.RemoveFromCart(id);
            cart.SaveChanges(this.HttpContext);

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
            ViewModels.ShoppingCart cart = ViewModels.ShoppingCart.GetCart(this.HttpContext);
            if (qty > 0 && qty < 50)
            {
                bool result = cart.ChangeQuantity(id, qty);
                cart.SaveChanges(this.HttpContext);
            }
            return RedirectToAction("ShoppingCartList", "Product");
        }
    }
}
