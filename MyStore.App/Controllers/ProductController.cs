using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using MyStore.App.Models.MyData;
using MyStore.App.ViewModels;
using MyStore.App.Utilities;

using PagedList;

namespace MyStore.App.Controllers
{
    public class ProductController : Controller
    {
        private MyStoreEntities db = new MyStoreEntities();

        #region **Private Functions**
        private int GetDefaultProductType()
        {
            var query = from q in db.Ref_Product_Type
                        where q.parent_product_type_id != null
                        orderby q.product_type_id
                        select q;
            int result = query.Select(p => p.product_type_id)
                              .FirstOrDefault();
            return result;
        }

        private string GetProductTypeName(int prodTypeID)
        {
            var query = db.Ref_Product_Type.Where(p => p.product_type_id == prodTypeID)
                                           .Select(p => p.product_type_description_vn);
            return query.SingleOrDefault();
        }

        private IList<ProductModel> GetRecommendProduct(int productId)
        {
            var products = from pro in db.Products
                           join puom in db.Unit_Of_Measure on pro.product_uom_id equals puom.UOM_id
                           where pro.product_type_id == db.Products.Where(p => p.product_id == productId)
                                                                   .Select(p => p.product_type_id)
                                                                   .FirstOrDefault()
                                && pro.product_id != productId
                           orderby pro.product_created_date descending
                           select new ProductModel()
                           {
                               Id = pro.product_id,
                               Name = pro.product_name,
                               Description = pro.product_description,
                               UOM = puom.UOM_description,
                               Price = pro.product_price,
                               Image = pro.product_image,
                               DateCreated = pro.product_created_date ?? DateTime.Now
                           };
            return products.Take(18)
                           .ToList();
        }

        #endregion

        public ActionResult ShowCart()
        {
            return View("ShoppingCart", CartHelper.GetCartDetail(this.HttpContext));
        }

        //
        // GET: /Product/
        public ActionResult Index(int? prodType, int? page, string searchString)
        {
            ViewBag.DateCompare = Convert.ToInt32(this.Session[GeneralContanstClass.Date_Compare_Session_Key]);

            int pageSize = Convert.ToInt32(this.Session[GeneralContanstClass.PageSize_Session_Key]);
            int pageNum = page ?? 1;

            var products = from pro in db.Products.Include("Unit_Of_Measure")
                           select pro;

            if (!string.IsNullOrEmpty(searchString))
            {
                ViewBag.ProductTypeName = MvcHtmlString.Create(string.Format("\"{0}\"", searchString));
                ViewBag.SearchString = searchString;
                products = products.Where(p => p.product_name.StartsWith(searchString));
            }
            else
            {
                prodType = prodType ?? GetDefaultProductType();
                ViewBag.ProductTypeName = GetProductTypeName(prodType ?? 0);
                ViewData.Add("prodType", prodType);
                products = products.Where(p => p.product_type_id == prodType);
            }

            var result = products.OrderByDescending(p => p.product_created_date)
                                 .Select(p => new ProductModel()
                                 {
                                     Id = p.product_id,
                                     Name = p.product_name,
                                     Description = p.product_description,
                                     UOM = p.Unit_Of_Measure.UOM_description,
                                     Price = p.product_price,
                                     Image = p.product_image,
                                     DateCreated = p.product_created_date ?? DateTime.Now
                                 });

            return View(result.ToPagedList(pageNum, pageSize));
        }

        //
        // GET: /Product/Details/5
        public ActionResult Details(int id = 0)
        {
            ViewBag.DateCompare = Convert.ToInt32(this.Session[GeneralContanstClass.Date_Compare_Session_Key]);

            var query = from pro in db.Products
                        join puom in db.Unit_Of_Measure on pro.product_uom_id equals puom.UOM_id
                        where pro.product_id == id
                        orderby pro.product_created_date descending
                        select new ProductModel()
                        {
                            Id = pro.product_id,
                            Name = pro.product_name,
                            Description = pro.product_description,
                            UOM = puom.UOM_description,
                            Price = pro.product_price,
                            Image = pro.product_image,
                            DateCreated = pro.product_created_date ?? DateTime.Now,
                            OtherDetails = pro.other_detail,
                            Total_Score = pro.total_vote_score ?? 0,
                            Total_Voted = pro.total_vote_count ?? 0
                        };
            ProductModel product = query.SingleOrDefault();
            if (product == null)
            {
                return HttpNotFound();
            }
            else
            {
                if (product.Total_Voted == 0)
                    ViewBag.BlogRate = 0;
                else
                    ViewBag.BlogRate = ((float)(product.Total_Score) / (float)(product.Total_Voted));

                ViewData.Add("RecommendProduct", GetRecommendProduct(id));
            }
            return View(product);
        }

        [HttpGet]
        public PartialViewResult ShowCompletedAddToCart(int selectedId)
        {
            ViewBag.RecommendTitle = "Các Sản Phẩm Liên Quan";
            return PartialView("_CompletedAddToCart", GetRecommendProduct(selectedId));
        }

        [HttpGet]
        public PartialViewResult RecommendProductPartial(IList<ProductModel> model)
        {
            ViewBag.RecommendTitle = "Shop Giới Thiệu";
            return PartialView("_RecommendItemsPartial", model);
        }

        [HttpGet]
        public PartialViewResult ShoppingCartList(IEnumerable<ShoppingCartViewModel> dataModel)
        {

            if (dataModel != null)
                return PartialView("_CartTablePartial", dataModel);
            else
                return PartialView("_CartTablePartial", CartHelper.GetCartDetail(this.HttpContext));
        }

        public PartialViewResult ListItemPartial(string strListTitle, IList<ProductModel> partialModel)
        {
            if (partialModel == null) return null;
            ViewBag.ListTitle = strListTitle;
            ViewBag.DateCompare = Convert.ToInt32(this.Session[GeneralContanstClass.Date_Compare_Session_Key]);

            return PartialView("_ListItemPartial", partialModel);
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }

    }
}