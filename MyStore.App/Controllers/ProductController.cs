using System;
using System.Collections;
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
        private int CheckProductTypeId(int proTypeID)
        {
            int result = 0;
            if (db.Ref_Product_Type.Any(p => p.product_type_id == proTypeID))
            {
                result = proTypeID;
            }
            else
            {
                result = GetDefaultProductType();
            }
            return result;
        }

        private int CheckProductTypeId(string slug)
        {
            int result = db.Ref_Product_Type
                           .Where(p => p.product_type_url == slug)
                           .Select(p => p.product_type_id)
                           .SingleOrDefault();
            if (result != 0)
            {
                return result;
            }
            else
            {
                return GetDefaultProductType();
            }
        }
        private int GetDefaultProductType()
        {
            var query = from q in db.Ref_Product_Type
                        where q.is_active
                        orderby q.product_type_id
                        select q.product_type_id;
            int result = query.First();
            return result;
        }

        private string GetProductTypeName(int prodTypeID)
        {
            int typeId = CheckProductTypeId(prodTypeID);

            var query = db.Ref_Product_Type
                          .Where(p => p.product_type_id == typeId)
                          .Select(p => p.product_type_title_vn);

            return query.SingleOrDefault();
        }

        private int GetProductTypeId(int prodID)
        {
            var query = db.Products.Where(p => p.product_id == prodID)
                                   .Select(p => p.product_type_id);
            int result = query.SingleOrDefault();
            return result == 0 ? 1 : result;
        }

        private string GetProductTypeSlug(int prodID)
        {
            var query = db.Products
                          .Where(p => p.product_id == prodID)
                          .Select(p => p.Ref_Product_Type.product_type_url);
            string result = query.SingleOrDefault();
            result = string.IsNullOrEmpty(result) ? GetProductTypeSlug(GetDefaultProductType()) : result;
            return result;
        }

        private IList<ProductModel> GetRecommendProduct(int productId)
        {
            int prodTypeId = db.Products.Where(p => p.product_id == productId)
                                        .Select(p => p.product_type_id)
                                        .FirstOrDefault();
            var products = from pro in db.Products
                           join puom in db.Unit_Of_Measure on pro.product_uom_id equals puom.UOM_id
                           where pro.product_type_id == prodTypeId
                           && pro.product_id < productId
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

            var diffProd = from pro in db.Products
                           join puom in db.Unit_Of_Measure on pro.product_uom_id equals puom.UOM_id
                           where pro.product_type_id == prodTypeId
                           && pro.product_id > productId
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

            return products.Union(diffProd)
                           .Take(20)
                           .ToList();
        }

        private IQueryable<ProductModel> GetFindQuery(int? prodType, string searchString, string sortString)
        {
            var products = from pro in db.Products
                                         .Include("Unit_Of_Measure")
                                         .Include("Ref_Product_Type")
                           select pro;
            if (!string.IsNullOrEmpty(searchString))
            {
                ViewBag.ProductTypeName = MvcHtmlString.Create(string.Format("\"{0}\"", searchString));
                ViewData["SearchString"] = searchString;
                products = products.Where(p => p.product_name.StartsWith(searchString) &&
                                               p.Ref_Product_Type.is_active);
            }
            else if (prodType != null && prodType.HasValue)
            {
                int currentType = CheckProductTypeId(prodType.Value);
                string prodTypeName = GetProductTypeName(currentType);

                ViewBag.ProductTypeName = prodTypeName;
                ViewData.Add("prodType", currentType);
                products = products.Where(p => p.product_type_id == currentType &&
                                               p.Ref_Product_Type.is_active);
            }
            else
            {
                products = products.Where(p => p.Ref_Product_Type.is_active);
            }

            var result = products.Select(p => new ProductModel()
                                 {
                                     Id = p.product_id,
                                     Name = p.product_name,
                                     Description = p.product_description,
                                     UOM = p.Unit_Of_Measure.UOM_description,
                                     Price = p.product_price,
                                     Image = p.product_image,
                                     DateCreated = p.product_created_date ?? DateTime.Now,
                                     Sale_Off = p.product_sale_off
                                 });
            if (!string.IsNullOrEmpty(sortString))
            {
                switch (sortString)
                {
                    case "Price-Asc":
                        result = result.OrderBy(p => p.Price);
                        break;
                    case "Price-Dsc":
                        result = result.OrderByDescending(p => p.Price);
                        break;
                    case "Date-Asc":
                        result = result.OrderBy(p => p.DateCreated);
                        break;
                    case "Date-Dsc":
                        result = result.OrderByDescending(p => p.DateCreated);
                        break;
                    default:
                        result = result.OrderByDescending(p => p.DateCreated);
                        break;
                }
            }
            else
                result = result.OrderByDescending(p => p.DateCreated);


            return result;
        }
        #endregion

        //
        // GET: /Product/'
        [HttpGet]
        public ActionResult Index(string slug)
        {
            int pageSize = Convert.ToInt32(this.Session[GeneralContanstClass.PageSize_Session_Key]);
            int prodTypeId = GetDefaultProductType();
            if (!string.IsNullOrEmpty(slug))
                prodTypeId = CheckProductTypeId(slug);
            var prdTypeQuery = from q in db.Ref_Product_Type
                               where q.product_type_id == prodTypeId
                               select new
                               {
                                   Title = q.product_type_title_vn,
                                   Description = q.product_type_description
                               };
            var prdTypeResult = prdTypeQuery.SingleOrDefault();
            IDictionary<string, string> dCrumbs = new Dictionary<string, string>();
            string strCrumb = prdTypeResult.Title;
            dCrumbs.Add(strCrumb, string.Empty);
            ViewData["BreadCrumbs"] = dCrumbs;
            var cookies = HttpContext.Request.Cookies.Get(GeneralContanstClass.SORT_STRING_COOKIES_KEY);

            var result = GetFindQuery(prodTypeId, string.Empty, cookies == null ? string.Empty : cookies.Value);

            ViewBag.DateCompare = Convert.ToInt32(this.Session[GeneralContanstClass.Date_Compare_Session_Key]);
            ViewBag.ProductTypeName = prdTypeResult.Title;
            ViewBag.ProductTypeDescription = prdTypeResult.Description;
            ViewBag.ImageName = string.Concat(slug, ".jpg");

            return View(result.Take(pageSize)
                              .ToList());
        }

        [HttpGet]
        public ActionResult SearchProduct(string searchString)
        {
            int pageSize = Convert.ToInt32(this.Session[GeneralContanstClass.PageSize_Session_Key]);

            IDictionary<string, string> dCrumbs = new Dictionary<string, string>();
            string strCrumb = "Tìm Kiếm";
            dCrumbs.Add(strCrumb, string.Empty);
            ViewData["BreadCrumbs"] = dCrumbs;
            var cookies = HttpContext.Request.Cookies.Get(GeneralContanstClass.SORT_STRING_COOKIES_KEY);
            var result = GetFindQuery(null, searchString, cookies == null ? string.Empty : cookies.Value);

            ViewBag.DateCompare = Convert.ToInt32(this.Session[GeneralContanstClass.Date_Compare_Session_Key]);
            ViewBag.ProductTypeName = searchString;
            ViewBag.ProductTypeDescription = "Hè Vải Sợi - Tìm Kiếm";
            ViewBag.ImageName = string.Empty;

            return View("Index", result.Take(pageSize)
                              .ToList());
        }

        //
        // GET: /Product/Details/5
        [HttpGet]
        public ActionResult Details(int id = 0)
        {
            var query = from pro in db.Products
                        join puom in db.Unit_Of_Measure on pro.product_uom_id equals puom.UOM_id
                        where pro.product_id == id
                        orderby pro.product_created_date descending
                        select new ProductModel()
                        {
                            Id = pro.product_id,
                            Type = pro.Ref_Product_Type.product_type_title_vn,
                            Name = pro.product_name,
                            Description = pro.product_description,
                            UOM = puom.UOM_description,
                            Price = pro.product_price,
                            Image = pro.product_image,
                            DateCreated = pro.product_created_date ?? DateTime.Now,
                            Sale_Off = pro.product_sale_off,
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
                ViewBag.DateCompare = Convert.ToInt32(this.Session[GeneralContanstClass.Date_Compare_Session_Key]);
                IDictionary<string, string> dCrumbs = new Dictionary<string, string>();
                dCrumbs.Add(product.Type, Url.Action("Index", "Product", new { @slug = GetProductTypeSlug(id) }));
                dCrumbs.Add("Chi Tiết", string.Empty);
                ViewData["BreadCrumbs"] = dCrumbs;
                if (product.Total_Voted == 0)
                    ViewBag.BlogRate = 0;
                else
                    ViewBag.BlogRate = ((float)(product.Total_Score) / (float)(product.Total_Voted));
                //Get all similar product
                ViewData.Add("RecommendProduct", GetRecommendProduct(id));
                //Get more detail images
                string productFolder = Server.MapPath(System.IO.Path.Combine("~/Images/shop", product.Image));
                if (System.IO.Directory.Exists(productFolder))
                {
                    string[] allFiles = System.IO.Directory.GetFiles(productFolder, "*footer*");
                    if (allFiles != null && allFiles.Length > 0)
                    {
                        IList<string> moreDetails = new List<string>();
                        for (int i = 0; i < allFiles.Length; i++)
                        {
                            moreDetails.Add(System.IO.Path.GetFileName(allFiles[i]));
                        }

                        ViewData.Add("DetailImg", moreDetails);
                    }
                }
            }
            return View(product);
        }

        [HttpGet]
        public PartialViewResult ShowCompletedAddToCart(int selectedId, string returnUrl)
        {
            ViewBag.RecommendTitle = "Các Sản Phẩm Liên Quan";
            ViewBag.ReturnUrl = returnUrl;
            return PartialView("_CompletedAddToCart", GetRecommendProduct(selectedId));
        }

        [HttpGet]
        public PartialViewResult RecommendProductPartial(IList<ProductModel> model)
        {
            ViewBag.RecommendTitle = "Shop Giới Thiệu";
            return PartialView("_RecommendItemsPartial", model);
        }

        [HttpGet]
        public PartialViewResult ListItemPartial(int? page, int? prodType, string searchString, string sortKey)
        {
            int pageSize = Convert.ToInt32(this.Session[GeneralContanstClass.PageSize_Session_Key]);
            int loadSize = Convert.ToInt32(this.Session[GeneralContanstClass.LoadSize_Session_Key]);
            int pageNum = page ?? 0;
            int pageSkip = pageSize + (loadSize * pageNum);
            ViewBag.DateCompare = Convert.ToInt32(this.Session[GeneralContanstClass.Date_Compare_Session_Key]);

            var result = GetFindQuery(prodType, searchString, sortKey);

            ViewData["IsEnded"] = result.Count() <= pageSkip;

            return PartialView("_ListItemsPartial", result.Skip(pageSkip)
                                                          .Take(loadSize)
                                                          .ToList());
        }
        [HttpGet]
        public PartialViewResult FeatureItemPartial(string strListTitle, IEnumerable<ProductModel> partialModel)
        {
            if (partialModel == null) return null;
            ViewBag.ListTitle = strListTitle;
            ViewBag.DateCompare = Convert.ToInt32(this.Session[GeneralContanstClass.Date_Compare_Session_Key]);

            CreateSortItems();
            return PartialView("_FeatureItemPartial", partialModel);
        }
        private void CreateSortItems()
        {
            IList<SelectListItem> sortItem1 = new List<SelectListItem>();
            SelectListItem dateItem = new SelectListItem()
            {
                Text = "Ngày Tạo",
                Value = "Date",
                Selected = true
            };
            sortItem1.Add(dateItem);

            SelectListItem priceItem = new SelectListItem()
            {
                Text = "Giá Tiền",
                Value = "Price",
                Selected = false
            };
            sortItem1.Add(priceItem);

            IList<SelectListItem> sortItem2 = new List<SelectListItem>();
            SelectListItem ascItem = new SelectListItem()
            {
                Text = "Tăng Dần",
                Value = "Asc",
                Selected = false
            };
            sortItem2.Add(ascItem);

            SelectListItem dscItem = new SelectListItem()
            {
                Text = "Giảm Dần",
                Value = "Dsc",
                Selected = true
            };
            sortItem2.Add(dscItem);
            var cookies = HttpContext.Request.Cookies.Get(GeneralContanstClass.SORT_STRING_COOKIES_KEY);
            if (cookies != null)
            {
                string selectedSort = Convert.ToString(cookies.Value);
                if (!string.IsNullOrEmpty(selectedSort))
                {
                    dateItem.Selected = selectedSort.Contains(dateItem.Value);
                    priceItem.Selected = selectedSort.Contains(priceItem.Value);
                    ascItem.Selected = selectedSort.Contains(ascItem.Value);
                    dscItem.Selected = selectedSort.Contains(dscItem.Value);
                }
            }
            ViewData.Add("SortList1", sortItem1);
            ViewData.Add("SortList2", sortItem2);
        }

        [HttpGet]
        public PartialViewResult AddToCompareProduct(int productId = 1)
        {
            IList<int> listCompare = this.Session[GeneralContanstClass.COMPARE_PRODUCT_SESSION_KEY] as List<int>;
            if (listCompare == null)
                listCompare = new List<int>();
            if (listCompare.Count >= 10)
            {
                ViewBag.CompareListTitle = string.Format("Quý khách đã dùng hết {0}/10 sản phẩm, bắt đầu so sánh ngay.", listCompare.Count);
            }
            else
            {
                if (!listCompare.Any(p => p == productId))
                {
                    listCompare.Add(productId);
                    this.Session[GeneralContanstClass.COMPARE_PRODUCT_SESSION_KEY] = listCompare;
                }
                ViewBag.CompareListTitle = string.Format("Danh sách tối đa 10 sản phẩm, quý khách đã dùng {0}/10 sản phẩm.", listCompare.Count);
            }

            var query = db.Products
                          .Where(p => listCompare.Contains(p.product_id))
                          .Select(p => new ProductModel()
                          {
                              Id = p.product_id,
                              Name = p.product_name,
                              Description = p.product_description,
                              UOM = p.Unit_Of_Measure.UOM_description,
                              Price = p.product_price,
                              Image = p.product_image,
                              DateCreated = p.product_created_date ?? DateTime.Now
                          })
                          .ToList();
            return PartialView("_ProductComparePartial", query);
        }

        [HttpGet]
        public PartialViewResult RemoveFromCompareProduct(int productId = 1)
        {
            IList<int> listCompare = this.Session[GeneralContanstClass.COMPARE_PRODUCT_SESSION_KEY] as List<int>;
            if (listCompare == null)
                listCompare = new List<int>();

            listCompare.Remove(productId);
            this.Session[GeneralContanstClass.COMPARE_PRODUCT_SESSION_KEY] = listCompare;

            if (listCompare.Count <= 0)
            {
                ViewBag.CompareListTitle = "Danh sách của quý khách đang rỗng.";
                return PartialView("_ProductComparePartial");
            }
            else
            {
                ViewBag.CompareListTitle = string.Format("Danh sách tối đa 10 sản phẩm, quý khách đã dùng {0}/10 sản phẩm.", listCompare.Count);
            }

            var query = db.Products
                          .Where(p => listCompare.Contains(p.product_id))
                          .Select(p => new ProductModel()
                          {
                              Id = p.product_id,
                              Name = p.product_name,
                              Description = p.product_description,
                              UOM = p.Unit_Of_Measure.UOM_description,
                              Price = p.product_price,
                              Image = p.product_image,
                              DateCreated = p.product_created_date ?? DateTime.Now
                          })
                          .ToList();
            return PartialView("_ProductComparePartial", query);
        }

        [HttpGet]
        public ActionResult Compare()
        {
            IDictionary<string, string> dCrumbs = new Dictionary<string, string>();
            dCrumbs.Add("So Sánh", string.Empty);
            ViewData["BreadCrumbs"] = dCrumbs;
            IList<int> listCompare = this.Session[GeneralContanstClass.COMPARE_PRODUCT_SESSION_KEY] as List<int>;
            if (listCompare == null)
            {
                return RedirectToAction("Index", "Home");
            }

            var query = db.Products
                          .Where(p => listCompare.Contains(p.product_id))
                          .Select(p => new ProductModel()
                          {
                              Id = p.product_id,
                              Description = p.product_description,
                              UOM = p.Unit_Of_Measure.UOM_description,
                              Price = p.product_price,
                              Image = p.product_image,
                              OtherDetails = p.other_detail,
                              Total_Score = p.total_vote_score ?? 0,
                              Total_Voted = p.total_vote_count ?? 0
                          })
                          .ToList();
            return View("Compare", query);
        }

        [HttpGet]
        public PartialViewResult GetImageDetail(int selectedIndex, string folderName)
        {
            ViewBag.FolderName = folderName;
            ViewBag.DetailImg = selectedIndex <= 0 ? "detail.jpg" : string.Concat("detail_", selectedIndex, ".jpg");
            ViewBag.OriginalImg = selectedIndex <= 0 ? "original.jpg" : string.Concat("original_", selectedIndex, ".jpg");

            return PartialView("_ProductImageDetails");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}