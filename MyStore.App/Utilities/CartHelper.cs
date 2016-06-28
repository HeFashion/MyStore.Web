using MyStore.App.ViewModels;
using MyStore.App.Models.MyData;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyStore.App.Utilities
{
    public class CartHelper
    {
        public static IList<ShoppingCartViewModel> GetCartDetail(ViewModels.ShoppingCart cart)
        {
            //ViewModels.ShoppingCart cart = ViewModels.ShoppingCart.GetCart(this.HttpContext);
            using (MyStoreEntities db = new MyStoreEntities())
            {
                IList<int> listId = cart.CartDetails
                                        .Select(p => p.ProductId)
                                        .ToList();
                var query = db.Products
                              .Include("Unit_Of_Measure")
                              .Where(p => listId.Contains(p.product_id))
                              .Select(p => new ShoppingCartViewModel()
                              {
                                  ProductId = p.product_id,
                                  ProductDescription = p.product_description,
                                  ProductImage = p.product_image,
                                  Price = p.product_price ?? 1,
                                  ProductName = p.product_name,
                                  UOM = p.Unit_Of_Measure.UOM_description
                              })
                              .ToList();

                foreach (var item in cart.CartDetails)
                {
                    var cartRow = query.Where(p => p.ProductId == item.ProductId)
                                       .SingleOrDefault();
                    if (cartRow != null)
                    {
                        item.ProductDescription = cartRow.ProductDescription;
                        item.ProductImage = cartRow.ProductImage;
                        item.Price = cartRow.Price;
                        item.ProductName = cartRow.ProductName;
                        item.UOM = cartRow.UOM;
                    }
                }
            }

            return cart.CartDetails;
        }

        public static IList<ShoppingCartViewModel> GetCartDetail(HttpContextBase baseContext)
        {
            ViewModels.ShoppingCart cart = ViewModels.ShoppingCart.GetCart(baseContext);
            return GetCartDetail(cart);
        }

        public static void EmptyCart(HttpContextBase baseContext)
        {
            baseContext.Session[ViewModels.ShoppingCart.CartSessionKey] = null;
        }
    }
}