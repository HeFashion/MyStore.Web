using MyStore.App.ViewModels;
using MyStore.App.Models.MyData;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebMatrix.WebData;
using System.Web.Mvc;
using System.Data.Entity;

namespace MyStore.App.Utilities
{
    public class CartHelper
    {
        // We're using HttpContextBase to allow access to cookies.
        public static Guid GetCartId(HttpContextBase context)
        {
            Guid cartId = Guid.Empty;
            HttpCookie cartCookie = context.Request.Cookies.Get(GeneralContanstClass.SHOPPING_CART_COOKIES_KEY);
            if (cartCookie == null)
            {
                cartId = Guid.NewGuid();
                cartCookie = new HttpCookie(GeneralContanstClass.SHOPPING_CART_COOKIES_KEY)
                {
                    Expires = DateTime.Now.AddDays(30),
                    Value = Convert.ToString(cartId)
                };
                context.Response.Cookies.Set(cartCookie);
            }
            else
            {
                Guid.TryParse(Convert.ToString(cartCookie.Value), out cartId);
                if (cartId == Guid.Empty)
                {
                    cartId = Guid.NewGuid();
                }
            }

            return cartId;
        }

        // We're using HttpContextBase to allow access to cookies.
        public static IList<ShoppingCartViewModel> GetCartDetail(HttpContextBase baseContext)
        {
            Guid id = GetCartId(baseContext);
            return GetCartDetails(id);
        }

        public static IList<ShoppingCartViewModel> GetCartDetails(Guid cartId)
        {
            using (MyStoreEntities db = new MyStoreEntities())
            {
                var query = from q in db.Cart_Items
                            join p in db.Products on q.product_id equals p.product_id
                            where q.cart_id == cartId
                            select new ShoppingCartViewModel()
                            {
                                ProductId = p.product_id,
                                ProductDescription = p.product_description,
                                ProductImage = p.product_image,
                                UOM = p.Unit_Of_Measure.UOM_description,
                                ProductName = p.product_name,
                                Price = p.product_price ?? 0,
                                TotalQuantity = q.cart_item_quantity ?? 1
                            };
                return query.ToList();
            }
        }

        // We're using HttpContextBase to allow access to cookies.
        public static void EmptyCart(HttpContextBase baseContext)
        {
            Guid id = GetCartId(baseContext);
            using (MyStoreEntities db = new MyStoreEntities())
            {
                var currentCart = db.Carts.Find(id);
                if (currentCart != null &&
                    currentCart.Cart_Items != null &&
                    currentCart.Cart_Items.Count > 0)
                {
                    foreach (var item in currentCart.Cart_Items.ToList())
                    {
                        db.Entry(item).State = EntityState.Deleted;
                    }
                    currentCart.Cart_Items.Clear();
                    db.SaveChanges();
                }
            }
        }

        public static void AddItem(Guid cartId, int prodId, double? prodQty)
        {
            using (MyStoreEntities db = new MyStoreEntities())
            {
                var currentCart = db.Carts.Find(cartId);
                if (currentCart == null)
                {
                    currentCart = new Models.MyData.Cart();
                    currentCart.cart_id = cartId;
                    currentCart.cart_created_date = DateTime.Now;
                    currentCart.Cart_Items.Add(new Models.MyData.Cart_Items()
                    {
                        product_id = prodId,
                        cart_item_quantity = prodQty
                    });
                    db.Carts.Add(currentCart);
                }
                else
                {
                    var cartItem = currentCart.Cart_Items
                                              .Where(p => p.product_id == prodId)
                                              .FirstOrDefault();
                    if (cartItem == null)
                    {
                        currentCart.Cart_Items.Add(new Models.MyData.Cart_Items()
                        {
                            product_id = prodId,
                            cart_item_quantity = prodQty
                        });
                    }
                    else
                    {
                        cartItem.cart_item_quantity += prodQty;
                    }
                }
                db.SaveChanges();
            }
        }

        public static bool RemoveItem(Guid cartId, int prodId)
        {
            using (MyStoreEntities db = new MyStoreEntities())
            {
                var currentCart = db.Carts.Find(cartId);
                if (currentCart == null) return false;

                var removeItem = currentCart.Cart_Items
                                            .Where(p => p.product_id == prodId)
                                            .FirstOrDefault();
                if (removeItem != null)
                    currentCart.Cart_Items.Remove(removeItem);

                db.SaveChanges();
            }
            return true;
        }

        public static bool ChangeQuantity(Guid cartId, int id, double qty)
        {
            using (MyStoreEntities db = new MyStoreEntities())
            {
                var currentCart = db.Carts.Find(cartId);
                if (currentCart == null)
                {
                    return false;
                }

                if (qty > 0 && qty < 50)
                {
                    var cartItem = currentCart.Cart_Items
                                              .Where(p => p.product_id == id)
                                              .SingleOrDefault();
                    if (cartItem == null)
                    {
                        cartItem = new Models.MyData.Cart_Items()
                        {
                            product_id = id,
                            cart_item_quantity = qty
                        };
                        currentCart.Cart_Items.Add(cartItem);
                    }
                    else
                        cartItem.cart_item_quantity = qty;
                }
                db.SaveChanges();
            }
            return true;
        }
    }
}