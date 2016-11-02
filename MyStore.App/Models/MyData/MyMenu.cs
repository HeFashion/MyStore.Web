using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using MyStore.App.ViewModels;
using MyStore.App.Models.MyData;

namespace MyStore.App.Models
{
    
    public static class MyMenu
    {
        public static IList<ProductTypeModel> BuildMenu()
        {
            using (MyStoreEntities dbContext = new MyStoreEntities())
            {
                //Get All Parent Menu
                var query1 = from menu in dbContext.Ref_Product_Type
                             where menu.parent_product_type_id == null &&
                                   menu.is_active == true
                             select new
                             {
                                 ParentId = menu.product_type_id,
                                 ParentName = menu.product_type_title_vn,
                                 ChildId = menu.parent_product_type_id,
                                 ChildName = menu.product_type_title_vn,
                                 OrderNo = menu.product_type_order,
                                 Url = menu.product_type_url
                             };

                //Get All Child Menu
                var query2 = from parent in dbContext.Ref_Product_Type
                             join child in dbContext.Ref_Product_Type
                                        on parent.product_type_id equals child.parent_product_type_id
                             where parent.is_active == true &&
                                   child.is_active == true
                             select new
                             {
                                 ParentId = parent.product_type_id,
                                 ParentName = parent.product_type_title_vn,
                                 ChildId = (int?)child.product_type_id,
                                 ChildName = child.product_type_title_vn,
                                 OrderNo = parent.product_type_order,
                                 Url = child.product_type_url
                             };

                var queryResult = query1.Union(query2)
                                        .OrderBy(p => p.OrderNo)
                                        .ToList();
                if (queryResult != null && queryResult.Count > 0)
                {
                    IList<ProductTypeModel> result = new List<ProductTypeModel>();
                    foreach (var menu in queryResult)
                    {
                        ProductTypeModel menuItem = null;
                        if (!result.Any(p => p.TypeId == menu.ParentId))
                        {
                            menuItem = new ProductTypeModel()
                            {
                                TypeId = menu.ParentId,
                                TypeDesc = menu.ParentName,
                                TotalProduct = dbContext.Products
                                                        .Count(p => p.product_type_id == menu.ParentId),
                                TypeUrl = menu.Url
                            };
                            result.Add(menuItem);
                        }
                        else
                        {
                            menuItem = result.Where(p => p.TypeId == menu.ParentId)
                                             .SingleOrDefault();
                        }

                        if (menu.ChildId != null)
                        {
                            if (menuItem.ChildType == null)
                                menuItem.ChildType = new List<ProductTypeModel>();
                            if (!menuItem.ChildType.Any(p => p.TypeId == (menu.ChildId ?? 0)))
                            {
                                menuItem.ChildType.Add(new ProductTypeModel()
                                {
                                    TypeId = menu.ChildId ?? 0,
                                    TypeDesc = menu.ChildName,
                                    TotalProduct = dbContext.Products
                                                            .Count(p => p.product_type_id == menu.ChildId),
                                    TypeUrl = menu.Url
                                    
                                });
                            }
                        }
                    }
                    return result;
                }
                return null;
            }
        }
    }
}