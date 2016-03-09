using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using BotDetect.Web.UI.Mvc;
using MyStore.App.ViewModels;
using MyStore.App.Utilities;

namespace MyStore.App.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            using (MyStore.App.Models.MyData.MyStoreEntities db = new Models.MyData.MyStoreEntities())
            {
                ViewData["slider"] = db.Ad_Sliders
                                       .Where(p => p.slider_active)
                                       .OrderBy(p => p.slider_id)
                                       .ToList();

                int dateCompare = Convert.ToInt32(this.Session[GeneralContanstClass.Date_Compare_Session_Key]);
                var newProduct = from pro in db.Products
                                 join puom in db.Unit_Of_Measure on pro.product_uom_id equals puom.UOM_id
                                 where System.Data.Objects.EntityFunctions.DiffDays(DateTime.Now, pro.product_created_date) >= dateCompare
                                 orderby pro.product_created_date descending
                                 select new ProductModel()
                                 {
                                     Id = pro.product_id,
                                     Type = pro.Ref_Product_Type.product_type_description_vn,
                                     Name = pro.product_name,
                                     Description = pro.product_description,
                                     UOM = puom.UOM_description,
                                     Price = pro.product_price,
                                     Image = pro.product_image,
                                     DateCreated = pro.product_created_date ?? DateTime.Now
                                 };

                ViewBag.DateCompare = Convert.ToInt32(this.Session[GeneralContanstClass.Date_Compare_Session_Key]);
                ViewData["new_product"] = newProduct.ToList();

            }
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your app description page.";

            return View();
        }

        public ActionResult Contact(bool? isDisplayMesg)
        {
            MvcCaptcha.ResetCaptcha("SimpleCaptcha");
            ViewBag.IsDisplayMesg = isDisplayMesg ?? false;

            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [CaptchaValidation("CaptchaCode", "SimpleCaptcha", "Mã số không đúng!")]
        public ActionResult OfferAdvice(MyStore.App.Models.MyData.User_Advices model)
        {
            if (ModelState.IsValid)
            {
                using (MyStore.App.Models.MyData.MyStoreEntities db = new Models.MyData.MyStoreEntities())
                {
                    db.User_Advices.Add(model);
                    db.SaveChanges();
                }

                return RedirectToAction("Contact");
            }
            MvcCaptcha.ResetCaptcha("SimpleCaptcha");
            return View("Contact", model);
        }
    }
}
