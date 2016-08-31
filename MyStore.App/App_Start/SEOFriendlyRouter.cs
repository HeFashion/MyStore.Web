using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Routing;

namespace MyStore.App
{
    public class SEOFriendlyRouter : Route
    {
        public SEOFriendlyRouter(string url, RouteValueDictionary defaults, IRouteHandler routeHandler)
            : base(url, defaults, routeHandler)
        {
        }
        private object GetIdValue(string slug)
        {
            if (!string.IsNullOrEmpty(slug))
            {
                var regex = new Regex(@"^(?<id>\d+).*$");
                var match = regex.Match(slug);

                if (match.Success)
                {
                    return match.Groups["id"].Value;
                }

            }
            return "0";
        }

        public override RouteData GetRouteData(HttpContextBase httpContext)
        {
            var routeData = base.GetRouteData(httpContext);
            if (routeData != null)
            {
                if (routeData.Values.ContainsKey("id"))
                {
                    routeData.Values["id"] = GetIdValue(Convert.ToString(routeData.Values["id"]));
                }
            }
            return routeData;
        }
    }
}