using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace WaveDisplay
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
            name: "SSEWaveform",
            url: "SSEWaveform/{deviceName}/{topicName}/{feedName}",
                defaults:
                    new
                    {
                        controller = "Home",
                        action = "SSEWaveform",
                        deviceName = UrlParameter.Optional,
                        topicName = UrlParameter.Optional,
                        feedName = UrlParameter.Optional
                    });

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
