using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Configuration;
using System.Configuration;

using MyStore.App.Utilities;

namespace MyStore.App
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {


        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            AuthConfig.RegisterAuth();

        }

        protected void Session_Start(object sender, EventArgs e)
        {
            // event is raised each time a new session is created     
            IList<MyStore.App.Models.Menu> myMenu = MyStore.App.Models.MyMenu.BuildMenu();
            this.Session[GeneralContanstClass.Menu_Session_Key] = myMenu;

            //get default value for web site
            var dateCompareSetting = ConfigurationManager.AppSettings[GeneralContanstClass.Date_Compare_Session_Key];
            if (string.IsNullOrEmpty(dateCompareSetting))
                this.Session[GeneralContanstClass.Date_Compare_Session_Key] = 0;
            else
                this.Session[dateCompareSetting] = Convert.ToInt32(dateCompareSetting);

            var pageSizeSetting = ConfigurationManager.AppSettings[GeneralContanstClass.PageSize_Session_Key];
            if (string.IsNullOrEmpty(dateCompareSetting))
                this.Session[GeneralContanstClass.PageSize_Session_Key] = 10;
            else
                this.Session[GeneralContanstClass.PageSize_Session_Key] = Convert.ToInt32(pageSizeSetting);
        }
    }
}