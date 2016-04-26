using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using PagedList;

using MyStore.App.Models.MyData;
using MyStore.App.ViewModels;
using MyStore.App.Utilities;

namespace MyStore.App.Controllers
{
    public class AdminController : Controller
    {
        private MyStoreEntities db = new MyStoreEntities();

        #region **Private Functions**

        private string SaveProductPhoto(HttpPostedFileBase photo, int? updatePhotoId = null)
        {
            if (photo == null || photo.ContentLength == 0) return string.Empty;

            int maxProductId = 0;
            if (updatePhotoId != null &&
                !updatePhotoId.HasValue)
            {
                maxProductId = updatePhotoId != null && updatePhotoId.HasValue ? updatePhotoId.Value : db.Products.Max(p => p.product_id);
                maxProductId += 1;
            }
            else
                maxProductId = updatePhotoId.Value;

            string fileName = string.Format("product{0}{1}", maxProductId, System.IO.Path.GetExtension(photo.FileName));
            //Save original image
            string filePath = Server.MapPath("~/Images/shop/product_original");
            photo.SaveAs(System.IO.Path.Combine(filePath, fileName));

            using (System.Drawing.Image photoImage = System.Drawing.Bitmap.FromStream(photo.InputStream))
            {
                //Save index image
                using (System.Drawing.Bitmap photoIndex = new System.Drawing.Bitmap(photoImage, 268, 249))
                {
                    filePath = Server.MapPath("~/Images/shop/product");
                    photoIndex.Save(System.IO.Path.Combine(filePath, fileName));
                }
                //Save detail image
                using (System.Drawing.Bitmap photoIndex = new System.Drawing.Bitmap(photoImage, 268, 249))
                {
                    filePath = Server.MapPath("~/Images/shop/product-details");
                    photoIndex.Save(System.IO.Path.Combine(filePath, fileName));
                }
                //Save recommend image
                using (System.Drawing.Bitmap photoIndex = new System.Drawing.Bitmap(photoImage, 268, 249))
                {
                    filePath = Server.MapPath("~/Images/shop/product-recommend");
                    photoIndex.Save(System.IO.Path.Combine(filePath, fileName));
                }

                //Save cart image
                using (System.Drawing.Bitmap photoIndex = new System.Drawing.Bitmap(photoImage, 110, 110))
                {
                    filePath = Server.MapPath("~/Images/cart");
                    photoIndex.Save(System.IO.Path.Combine(filePath, fileName));
                }
            }

            return fileName;
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }

        #endregion

        #region Product Management

        //
        // GET: /Admin/

        [Authorize(Roles = "Admin")]
        public ActionResult Index(string sortOrder, string searchString, int? page)
        {
            int pageSize = Convert.ToInt32(this.Session[GeneralContanstClass.PageSize_Session_Key]);
            int pageNum = page ?? 1;

            var products = from q in db.Products
                           join t in db.Ref_Product_Type on q.product_type_id equals t.product_type_id
                           join u in db.Unit_Of_Measure on q.product_uom_id equals u.UOM_id
                           select q;
            ViewBag.SortOrder = string.IsNullOrEmpty(sortOrder) ? "Type" : sortOrder;
            ViewBag.SearchString = searchString;
            if (!string.IsNullOrEmpty(searchString))
            {
                products = products.Where(p => p.product_name.StartsWith(searchString));
            }
            switch (sortOrder)
            {
                case "Name":
                    products = products.OrderByDescending(p => p.product_name);
                    break;
                default:
                    products = products.OrderByDescending(p => p.product_type_id);
                    break;
            }
            return View(products.ToPagedList(pageNum, pageSize));
        }

        //
        // GET: /Admin/Create

        [Authorize(Roles = "Admin")]
        public ActionResult Create()
        {
            ViewBag.product_type_id = new SelectList(db.Ref_Product_Type, "product_type_id", "product_type_description_vn");
            ViewBag.product_uom_id = new SelectList(db.Unit_Of_Measure, "UOM_id", "UOM_description");
            return View("CreateProduct");
        }

        //
        // POST: /Admin/Create

        //
        // POST: /Product/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Product product)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    HttpPostedFileBase photo = Request.Files["productImg"];
                    product.product_image = SaveProductPhoto(photo);
                    product.product_created_date = DateTime.Now;

                    db.Products.Add(product);
                    db.SaveChanges();
                }
                catch (Exception ex)
                {
                    throw ex;
                }

                return RedirectToAction("Index");
            }
            ViewBag.product_type_id = new SelectList(db.Ref_Product_Type,
                                                    "product_type_id",
                                                    "product_type_description_vn",
                                                    product.product_type_id);
            ViewBag.product_uom_id = new SelectList(db.Unit_Of_Measure.Where(p => p.Del_Flag == false),
                                                    "UOM_id",
                                                    "UOM_description",
                                                    product.product_uom_id);
            return View(product);
        }

        //
        // GET: /Admin/Edit/5

        [Authorize(Roles = "Admin")]
        public ActionResult Edit(int id = 0)
        {
            Product product = db.Products.Single(p => p.product_id == id);
            if (product == null)
            {
                return HttpNotFound();
            }
            ViewBag.product_type_id = new SelectList(db.Ref_Product_Type,
                                                     "product_type_id",
                                                     "product_type_description_vn",
                                                     product.product_type_id);
            ViewBag.product_uom_id = new SelectList(db.Unit_Of_Measure.Where(p => p.Del_Flag == false),
                                                    "UOM_id",
                                                    "UOM_description",
                                                    product.product_uom_id);
            return View("EditProduct", product);
        }

        //
        // POST: /Admin/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Product product)
        {
            if (ModelState.IsValid)
            {
                HttpPostedFileBase photo = Request.Files["productImg"];
                string strImage = SaveProductPhoto(photo, product.product_id);
                if (!string.IsNullOrEmpty(strImage))
                    product.product_image = strImage;

                db.Products.Attach(product);
                db.Entry(product).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.product_type_id = new SelectList(db.Ref_Product_Type, "product_type_id", "product_type_description_vn", product.product_type_id);
            ViewBag.product_uom_id = new SelectList(db.Unit_Of_Measure, "UOM_id", "UOM_description", product.product_uom_id);
            return View(product);
        }

        //
        // GET: /Admin/Delete/5

        [Authorize(Roles = "Admin")]
        public ActionResult Delete(int id = 0)
        {
            Product product = db.Products.Single(p => p.product_id == id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View("DeleteProduct", product);
        }

        //
        // POST: /Admin/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Product product = db.Products.Single(p => p.product_id == id);
            db.Products.Remove(product);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        #endregion

        #region Product Catalog Management
        [Authorize(Roles = "Admin")]
        public ActionResult ListOfCatalog()
        {
            var model = db.Ref_Product_Type
                          .Where(p => p.parent_product_type_id == null)
                          .Include("Child_Product_Types");
            return View("IndexProductCatalog", model.ToList());
        }

        [Authorize(Roles = "Admin")]
        public ActionResult CreateCatalog()
        {
            var parentType = db.Ref_Product_Type.Where(p => p.parent_product_type_id == null);
            ViewBag.parent_product_type_id = new SelectList(parentType, "product_type_id", "product_type_description_vn");
            return View("CreateProductCatalog");
        }

        //
        // POST: /Admin/Create

        //
        // POST: /Product/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateCatalog(Ref_Product_Type productType)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    db.Ref_Product_Type.Add(productType);
                    db.SaveChanges();
                }
                catch (Exception ex)
                {
                    throw ex;
                }

                return RedirectToAction("ListOfCatalog");
            }
            return View(productType);
        }

        [Authorize(Roles = "Admin")]
        public ActionResult EditCatalog(int id = 0)
        {
            Ref_Product_Type productType = db.Ref_Product_Type
                                             .Include("Parent_Product_Type")
                                             .Single(p => p.product_type_id == id);
            if (productType == null)
            {
                return HttpNotFound();
            }
            var parentType = db.Ref_Product_Type
                               .Where(p => p.parent_product_type_id == null);
            ViewBag.parent_product_type_id = new SelectList(parentType,
                                                            "product_type_id",
                                                            "product_type_description_vn",
                                                            productType.parent_product_type_id);
            return View("EditCatalog", productType);
        }

        //
        // POST: /Admin/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditCatalog(Ref_Product_Type productType)
        {
            if (ModelState.IsValid)
            {
                db.Ref_Product_Type.Attach(productType);
                db.Entry(productType).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            var parentType = db.Ref_Product_Type
                              .Where(p => p.parent_product_type_id == null);
            ViewBag.parent_product_type_id = new SelectList(parentType,
                                                            "product_type_id",
                                                            "product_type_description_vn");

            return View(productType);
        }

        [Authorize(Roles = "Admin")]
        public ActionResult DeleteCatalog(int id = 0)
        {
            Ref_Product_Type obj = db.Ref_Product_Type.Single(p => p.product_type_id == id);
            if (obj == null)
            {
                return HttpNotFound();
            }
            if (obj.Child_Product_Types.Count > 0)
            {
                ModelState.AddModelError("", "Delete all child catalog before delete this catalog");

            }

            return View("DeleteCatalog", obj);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteCatalogConfirmed(int id)
        {
            Ref_Product_Type obj = db.Ref_Product_Type.Single(p => p.product_type_id == id);
            if (obj.Child_Product_Types.Count > 0)
            {
                ModelState.AddModelError("", "Delete all child catalog before delete this catalog");
                return View("DeleteCatalog", obj);
            }
            db.Ref_Product_Type.Remove(obj);
            db.SaveChanges();
            return RedirectToAction("ListOfCatalog");
        }

        #endregion

        #region Unit Of Measure
        [Authorize(Roles = "Admin")]
        public ActionResult ListOfUOM()
        {
            var model = db.Unit_Of_Measure;
            return View("IndexUOM", model.ToList());
        }

        [Authorize(Roles = "Admin")]
        public ActionResult EditUOM(int id = 0)
        {
            Unit_Of_Measure obj = db.Unit_Of_Measure
                                    .Where(p => p.UOM_id == id)
                                    .SingleOrDefault();
            if (obj == null)
            {
                return HttpNotFound();
            }

            return View("EditUOM", obj);
        }

        //
        // POST: /Admin/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditUOM(Unit_Of_Measure updateObj)
        {
            if (ModelState.IsValid)
            {
                db.Unit_Of_Measure.Attach(updateObj);
                db.Entry(updateObj).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("ListOfUOM");
            }

            return View(updateObj);
        }

        [Authorize(Roles = "Admin")]
        public ActionResult DeleteUOM(int id = 0)
        {
            Unit_Of_Measure obj = db.Unit_Of_Measure.Single(p => p.UOM_id == id);
            if (obj == null)
            {
                return HttpNotFound();
            }
            if (obj.Products.Count > 0)
            {
                ModelState.AddModelError(string.Empty, "Cannot delete this UOM. Some products is using it.");
            }
            return View("DeleteUOM", obj);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteUOMConfirmed(int id)
        {
            Unit_Of_Measure obj = db.Unit_Of_Measure.Single(p => p.UOM_id == id);
            if (obj.Products.Count > 0)
            {
                ModelState.AddModelError(string.Empty, "Cannot delete this UOM. Some products is using it.");
                return View("DeleteUOM", obj);
            }
            db.Unit_Of_Measure.Remove(obj);
            db.SaveChanges();
            return RedirectToAction("ListOfCatalog");
        }

        #endregion

        #region Ad-Slider Management

        [Authorize(Roles = "Admin")]
        public ActionResult ListOfSlider(bool isActive = true)
        {
            ViewData["IsActive"] = isActive;
            var model = db.Ad_Sliders
                          .Where(p => p.slider_active == isActive);
            return View("IndexAdvertisement", model.ToList());
        }

        [Authorize(Roles = "Admin")]
        public ActionResult CreateAd()
        {
            return View("CreateAdvertisement");
        }

        //
        // POST: /Admin/Create

        //
        // POST: /Product/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateAd(Ad_Sliders obj)
        {
            if (ModelState.IsValid)
            {
                db.Ad_Sliders.Add(obj);
                db.Entry(obj).State = EntityState.Added;
                db.SaveChanges();
                return RedirectToAction("ListOfSlider");
            }

            return View("CreateAdvertisement", obj);
        }
        [Authorize(Roles = "Admin")]
        public ActionResult EditSlider(int id = 0)
        {
            var obj = db.Ad_Sliders
                          .Where(p => p.slider_id == id)
                          .SingleOrDefault();
            if (obj == null)
            {
                return HttpNotFound();
            }

            return View("EditAdvertisement", obj);
        }

        //
        // POST: /Admin/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditSlider(Ad_Sliders updateObj)
        {
            if (ModelState.IsValid)
            {
                db.Ad_Sliders.Attach(updateObj);
                db.Entry(updateObj).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("ListOfSlider");
            }

            return View(updateObj);
        }

        [Authorize(Roles = "Admin")]
        public ActionResult DeleteAd(int id = 0)
        {
            Ad_Sliders obj = db.Ad_Sliders.Single(p => p.slider_id == id);
            if (obj == null)
            {
                return HttpNotFound();
            }

            return View("DeleteAdvertisement", obj);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteAdConfirmed(int id)
        {
            Ad_Sliders obj = db.Ad_Sliders.Single(p => p.slider_id == id);
            db.Ad_Sliders.Remove(obj);
            db.SaveChanges();
            return RedirectToAction("ListOfSlider");
        }
        #endregion

        #region Order Management

        public ActionResult ListOfOrder()
        {
            var lstOrders = db.Orders
                              .Include("Order_Status_Codes")
                              .Include("Shipping_Bills")
                              .Select(o => new OrderViewModel()
                              {
                                  OrderNumber = o.order_id,
                                  Status = o.Order_Status_Codes.order_status_description,
                                  Address = o.order_address,
                                  DateCreated = o.date_order_placed ?? DateTime.Now,
                                  StatusId = o.order_status_id,
                                  PhoneNumber = o.phone_number,
                                  ReceiverName = o.receipter_name,
                                  ShippingDate = o.Shipping_Bills.shipping_date,
                                  ShippingCode = o.Shipping_Bills.shipping_code
                              });
            ViewData["OrderStatus"] = db.Order_Status_Codes
                                        .Select(p => p.order_status_description)
                                        .ToList();
            return View("IndexOrders", lstOrders);
        }

        private const string SHIP_ORDER_SESSION_KEY = "ShipOrdersSession";
        [HttpPost]
        public PartialViewResult ShipOrders(IList<string> selectedOrder)
        {
            this.HttpContext.Session[SHIP_ORDER_SESSION_KEY] = selectedOrder;
            return PartialView("_ShipProductPartial");
        }
        [HttpPost]
        public ActionResult ShipOrdersConfirmed(ShippingInfoViewModel model)
        {
            string[] selectedOrder = this.HttpContext.Session[SHIP_ORDER_SESSION_KEY] as string[];
            if (selectedOrder == null ||
                selectedOrder.Length == 0)
            {
                ModelState.AddModelError(string.Empty, "Nothing was selected. Cannot save.");
                return ListOfOrder();
            }
            else
            {
                Shipping_Bills newShipBill = new Shipping_Bills();
                newShipBill.shipping_date = model.ShipDate;
                newShipBill.shipping_code = model.ShipCode;

                foreach (string item in selectedOrder)
                {
                    var order = db.Orders.Find(Convert.ToInt32(item));
                    if (order == null) continue;
                    order.order_status_id = OrderStatus.Shipping;

                    newShipBill.Orders.Add(order);
                }
                db.Shipping_Bills.Add(newShipBill);
                db.SaveChanges();
                return RedirectToAction("ListOfOrder");
            }
        }

        [HttpPost]
        public ActionResult ChangeOrderToComplete(IList<string> selectedOrder)
        {
            return ChangeOrderStatus(selectedOrder, OrderStatus.Done);
        }

        [HttpPost]
        public ActionResult ChangeOrderToCancel(IList<string> selectedOrder)
        {
            return ChangeOrderStatus(selectedOrder, OrderStatus.Cancel);
        }

        private ActionResult ChangeOrderStatus(IList<string> selectedOrder, OrderStatus status)
        {
            if (selectedOrder != null &&
                selectedOrder.Count != 0)
            {
                foreach (var orderId in selectedOrder)
                {
                    var obj = db.Orders.Find(Convert.ToInt32(orderId));
                    if (obj == null) continue;
                    obj.order_status_id = status;
                }
                db.SaveChanges();
                return RedirectToAction("ListOfOrder");
            }

            ModelState.AddModelError(string.Empty, "Nothing was selected. Cannot save.");
            return ListOfOrder();
        }
        #endregion
        public PartialViewResult GetFileListPartial(string folderName)
        {
            string virtualPath = System.IO.Path.Combine("~/Images", folderName);
            string physicalPath = Server.MapPath(virtualPath);
            IList<string> listFiles = new List<string>();
            foreach (var item in System.IO.Directory.GetFiles(physicalPath))
            {
                string pathTemp = System.IO.Path.Combine(virtualPath, System.IO.Path.GetFileName(item)).Replace("\\", "/");
                listFiles.Add(pathTemp);
            }
            return PartialView("_ListFilePartial", listFiles);
        }
    }
}