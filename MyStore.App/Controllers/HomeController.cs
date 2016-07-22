using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using BotDetect.Web.UI.Mvc;
using PagedList;

using MyStore.App.ViewModels;
using MyStore.App.Utilities;

namespace MyStore.App.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index(string sortString)
        {
            using (MyStore.App.Models.MyData.MyStoreEntities db = new Models.MyData.MyStoreEntities())
            {
                ViewBag.ListTitle = "Tất Cả Các Mặt Hàng";
                ViewData["slider"] = db.Ad_Sliders
                                       .Where(p => p.slider_active)
                                       .OrderBy(p => p.slider_id)
                                       .ToList();

                ViewBag.DateCompare = this.Session[GeneralContanstClass.Date_Compare_Session_Key] != null ?
                                      Convert.ToInt32(this.Session[GeneralContanstClass.Date_Compare_Session_Key]) :
                                      10;

                int pageSize = Convert.ToInt32(this.Session[GeneralContanstClass.PageSize_Session_Key]);

                var model = from pro in db.Products
                                      .Include("Unit_Of_Measure")
                                      .Include("Ref_Product_Type")
                            where pro.Ref_Product_Type.is_active
                            select new ProductModel()
                            {
                                Id = pro.product_id,
                                Type = pro.Ref_Product_Type.product_type_description_vn,
                                Name = pro.product_name,
                                Description = pro.product_description,
                                UOM = pro.Unit_Of_Measure.UOM_description,
                                Price = pro.product_price,
                                Image = pro.product_image,
                                DateCreated = pro.product_created_date ?? DateTime.Now
                            };
                switch (sortString)
                {
                    case "PriceAsc":
                        model.OrderBy(p => p.Price);
                        break;
                    case "PriceDsc":
                        model.OrderByDescending(p => p.Price);
                        break;
                    case "DateAsc":
                        model.OrderBy(p => p.Price);
                        break;
                    case "DateDsc":
                        model.OrderByDescending(p => p.Price);
                        break;
                    default:
                        model.OrderByDescending(p => p.DateCreated);
                        break;
                }

                var recommendList = from rec in db.Product_Recommend
                                    join prd in db.Products on rec.product_id equals prd.product_id
                                    where prd.Ref_Product_Type.is_active
                                    orderby rec.recommend_order
                                    select new ProductModel()
                                    {
                                        Id = prd.product_id,
                                        Name = prd.product_image,
                                        Description = prd.product_description,
                                        UOM = prd.Unit_Of_Measure.UOM_description,
                                        Price = prd.product_price,
                                        Image = prd.product_image,
                                        DateCreated = prd.product_created_date ?? DateTime.Now
                                    };
                ViewData["RecommendList"] = recommendList.ToList();

                return View("Index", model.Take(pageSize).ToList());
            }
        }

        public ActionResult About()
        {
            ViewBag.Message = "Hè-Vải Sợi xin giới thiệu";
            IDictionary<string, string> dCrumbs = new Dictionary<string, string>();
            dCrumbs.Add("Giới Thiệu", string.Empty);
            ViewData["BreadCrumbs"] = dCrumbs;

            return View();
        }

        public ActionResult Contact(bool? isDisplayMesg)
        {
            MvcCaptcha.ResetCaptcha("SimpleCaptcha");
            ViewBag.IsDisplayMesg = isDisplayMesg ?? false;
            IDictionary<string, string> dCrumbs = new Dictionary<string, string>();
            dCrumbs.Add("Địa Điểm", string.Empty);
            ViewData["BreadCrumbs"] = dCrumbs;

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

        public PartialViewResult ItemSliderPartial(int sliderId, bool isActive = false)
        {
            MyStore.App.Models.MyData.Ad_Sliders slider = null;
            using (MyStore.App.Models.MyData.MyStoreEntities db = new Models.MyData.MyStoreEntities())
            {
                slider = db.Ad_Sliders
                           .Where(p => p.slider_id == sliderId)
                           .SingleOrDefault();
            }

            ViewBag.ActiveItem = isActive;
            return PartialView("_ItemSliderPartial", slider);
        }
    }
}
