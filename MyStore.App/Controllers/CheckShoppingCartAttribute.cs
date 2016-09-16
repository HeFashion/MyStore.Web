using MyStore.App.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MyStore.App.Controllers
{
    public class CheckShoppingCartAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            //Check ShoppingCart is emptly
            var shoppingCart = CartHelper.GetCartDetail(filterContext.HttpContext);
            if (shoppingCart == null || shoppingCart.Count <= 0)
            {
                filterContext.HttpContext.Response.Redirect("~/Cart/ShowCart");
            }
        }
    }
}