using System.Web;
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
#if (!DEBUG)
 "~/Scripts/facebook.js",
               "~/Scripts/googleplus.js",
               "~/Scripts/googleAnalysis.js",
               "~/Scripts/tawkTo.js",
#endif
 "~/Scripts/jquery.cookie-{version}.js",
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

            bundles.Add(new StyleBundle("~/Content/admincss").Include(
                "~/Content/site.css",
                "~/Content/PagedList.css"));

            bundles.Add(new StyleBundle("~/Content/themes/base/css").Include(
                        "~/Content/themes/base/jquery-ui.css",
                        "~/Content/themes/base/core.css",
                        "~/Content/themes/base/resizable.css",
                        "~/Content/themes/base/selectable.css",
                        "~/Content/themes/base/accordion.css",
                        "~/Content/themes/base/autocomplete.css",
                        "~/Content/themes/base/button.css",
                        "~/Content/themes/base/dialog.css",
                        "~/Content/themes/base/slider.css",
                        "~/Content/themes/base/tabs.css",
                        "~/Content/themes/base/datepicker.css",
                        "~/Content/themes/base/progressbar.css",
                        "~/Content/themes/base/theme.css"));

            bundles.Add(new StyleBundle("~/Content/themes/mystyle/bootstrap").Include(
                        "~/Content/themes/mystyle/bootstrap.css",
                        "~/Content/themes/mystyle/bootstrap-social.css"));

            bundles.Add(new StyleBundle("~/Content/themes/mystyle/css").Include(
                        "~/Content/themes/mystyle/bootstrap.css",
                        "~/Content/themes/mystyle/font-awesome.css",
                        "~/Content/themes/mystyle/prettyPhoto.css",
#if (DEBUG)
 "~/Content/themes/mystyle/price-range.css",
#endif
                        "~/Content/themes/mystyle/bootstrap-social.css",
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
               "~/Scripts/rateObject.js"));
            bundles.Add(new ScriptBundle("~/bundles/blog/details").Include(
                "~/Scripts/jquery.rateyo.js",
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