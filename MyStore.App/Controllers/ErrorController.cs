using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MyStore.App.Controllers
{
    public class ErrorController : Controller
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(typeof(ErrorController));
        public ActionResult Index()
        {
            log.Debug("test begin");
            var error = Server.GetLastError();
            if (error != null)
                ViewBag.ErrorMessage = error.Message;
            log.Error(error);

            log.Debug("test end");
            return View();
        }
        // GET: Error
        public ActionResult NotFound()
        {
            Response.StatusCode = 404;
            return View();
        }
    }
}