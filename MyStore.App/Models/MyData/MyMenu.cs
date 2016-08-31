using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using MyStore.App.Models.MyData;

namespace MyStore.App.Models
{
    public class Menu
    {
        public int MenuId { get; set; }
        public string MenuUrl { get; set; }
        public string MenuDesc { get; set; }
        public List<Menu> ChildMenu { get; set; }
        public int TotalProduct { get; set; }
        public short MenuOrder { get; set; }
    }
    public static class MyMenu
    {
        public static IList<Menu> BuildMenu()
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
                                 ParentName = menu.product_type_description_vn,
                                 ChildId = menu.parent_product_type_id,
                                 ChildName = menu.product_type_description_vn,
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
                                 ParentName = parent.product_type_description_vn,
                                 ChildId = (int?)child.product_type_id,
                                 ChildName = child.product_type_description_vn,
                                 OrderNo = parent.product_type_order,
                                 Url = child.product_type_url
                             };

                var queryResult = query1.Union(query2)
                                        .OrderBy(p => p.OrderNo)
                                        .ToList();
                if (queryResult != null && queryResult.Count > 0)
                {
                    IList<Menu> result = new List<Menu>();
                    foreach (var menu in queryResult)
                    {
                        Menu menuItem = null;
                        if (!result.Any(p => p.MenuId == menu.ParentId))
                        {
                            menuItem = new Menu()
                            {
                                MenuId = menu.ParentId,
                                MenuDesc = menu.ParentName,
                                TotalProduct = dbContext.Products
                                                        .Count(p => p.product_type_id == menu.ParentId),
                                MenuUrl = menu.Url
                            };
                            result.Add(menuItem);
                        }
                        else
                        {
                            menuItem = result.Where(p => p.MenuId == menu.ParentId)
                                             .SingleOrDefault();
                        }

                        if (menu.ChildId != null)
                        {
                            if (menuItem.ChildMenu == null)
                                menuItem.ChildMenu = new List<Menu>();
                            if (!menuItem.ChildMenu.Any(p => p.MenuId == (menu.ChildId ?? 0)))
                            {
                                menuItem.ChildMenu.Add(new Menu()
                                {
                                    MenuId = menu.ChildId ?? 0,
                                    MenuDesc = menu.ChildName,
                                    TotalProduct = dbContext.Products
                                                            .Count(p => p.product_type_id == menu.ChildId),
                                    MenuUrl = menu.Url
                                    
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