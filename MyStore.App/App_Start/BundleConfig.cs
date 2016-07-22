﻿using System.Web;
using System.Web.Optimization;


namespace MyStore.App
{
    public class BundleConfig
    {
        // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkId=254725
        public static void RegisterBundles(BundleCollection bundles)
        {
            //BundleTable.EnableOptimizations = true;

            bundles.Add(new ScriptBundle("~/bundles/main/jquery").Include(
                        "~/Scripts/jquery-{version}.js",
                        "~/Scripts/jquery-ui-{version}.js",
                        "~/Scripts/jquery.unobtrusive*",
                        "~/Scripts/jquery.validate*",
                        "~/Scripts/bootstrap.js",
                        "~/Scripts/price-range.js",
                        "~/Scripts/jquery.scrollUp.js",
                        "~/Scripts/jquery.prettyPhoto.js",
                        "~/Scripts/jquery.cookie-{version}.js",
#if (!DEBUG)
               "~/Scripts/googleAnalysis.js",
#endif
 "~/Scripts/main.js"
                        ));
            bundles.Add(new ScriptBundle("~/bundles/admin/jquery").Include(
                        "~/Scripts/jquery-{version}.js",
                        "~/Scripts/jquery-ui-{version}.js",
                        "~/Scripts/jquery.unobtrusive*",
                        "~/Scripts/jquery.validate*",
                        "~/Scripts/modernizr-*",
                        "~/Scripts/main.admin.js"
                        ));
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"
                        ));

            bundles.Add(new ScriptBundle("~/bundles/jqueryui").Include(
                        "~/Scripts/jquery-ui-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.unobtrusive*",
                        "~/Scripts/jquery.validate*"));

            bundles.Add(new ScriptBundle("~/bundles/contact").Include(
                "~/Scripts/gmaps.js",
                "~/Scripts/contact.js"
                ));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new StyleBundle("~/Content/AdminCss").Include(
                "~/Content/site.css",
                "~/Content/PagedList.css"));
            bundles.Add(new StyleBundle("~/Content/themes/base/jquery.dialog").Include(
                "~/Content/themes/base/jquery.ui.core.css",
                "~/Content/themes/base/jquery.ui.dialog.css"));

            bundles.Add(new StyleBundle("~/Content/themes/base/css").Include(
                        "~/Content/themes/base/jquery.ui.core.css",
                        "~/Content/themes/base/jquery.ui.resizable.css",
                        "~/Content/themes/base/jquery.ui.selectable.css",
                        "~/Content/themes/base/jquery.ui.accordion.css",
                        "~/Content/themes/base/jquery.ui.autocomplete.css",
                        "~/Content/themes/base/jquery.ui.button.css",
                        "~/Content/themes/base/jquery.ui.dialog.css",
                        "~/Content/themes/base/jquery.ui.slider.css",
                        "~/Content/themes/base/jquery.ui.tabs.css",
                        "~/Content/themes/base/jquery.ui.datepicker.css",
                        "~/Content/themes/base/jquery.ui.progressbar.css",
                        "~/Content/themes/base/jquery.ui.theme.css"));

            bundles.Add(new StyleBundle("~/Content/themes/mystyle/bootstrap").Include(
                        "~/Content/themes/mystyle/bootstrap.css",
                        "~/Content/themes/mystyle/bootstrap-social.css"));

            bundles.Add(new StyleBundle("~/Content/themes/mystyle/css").Include(
                        "~/Content/themes/mystyle/bootstrap.css",
                        "~/Content/themes/mystyle/bootstrap-social.css",
                        "~/Content/themes/mystyle/font-awesome.css",
                        "~/Content/themes/mystyle/prettyPhoto.css",
                        "~/Content/themes/mystyle/price-range.css",
                        "~/Content/themes/mystyle/animate.css",
                        "~/Content/themes/mystyle/main.css",
                        "~/Content/themes/mystyle/responsive.css"));

            bundles.Add(new StyleBundle("~/bundles/bootstapadmin").Include(
                "~/Content/themes/mystyle/bootstrap.css",
                "~/Content/themes/mystyle/responsive.css"));

            bundles.Add(new ScriptBundle("~/bundles/product/details").Include(
               "~/Scripts/product.detail.js",
               "~/Scripts/jquery.rateyo.js",
               "~/Scripts/jquery.elevateZoom.js",
               "~/Scripts/numericInput.js",
               "~/Scripts/addtocart.js",
#if (!DEBUG)
               "~/Scripts/facebook.js",
               "~/Scripts/googleplus.js",
#endif
 "~/Scripts/rateObject.js"));
            bundles.Add(new ScriptBundle("~/bundles/blog/details").Include(
                "~/Scripts/jquery.rateyo.js",
#if (!DEBUG)
               "~/Scripts/facebook.js",
               "~/Scripts/googleplus.js",
#endif
 "~/Scripts/rateObject.js"
                ));
            bundles.Add(new ScriptBundle("~/bundles/product/compare").Include(
              "~/Scripts/jquery.elevateZoom.js",
              "~/Scripts/addtocart.js"));

            bundles.Add(new ScriptBundle("~/bundles/home/index").Include(
             "~/Scripts/addtocart.js"));
            bundles.Add(new ScriptBundle("~/bundles/cart/shopping").Include(
            "~/Scripts/numericInput.js",
            "~/Scripts/shoppingCart.js"));
        }
    }
}