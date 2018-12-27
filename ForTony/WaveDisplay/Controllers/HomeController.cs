using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WaveDisplay.Controllers
{
    [Authorize(Roles = "XNRest")]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            //return SSEWaveform();
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        //        [Route("SSEWaveform/{deviceName}/{topicName}/{feedName}")]
        public ActionResult SSEWaveform(string deviceName, string topicName, string feedName)
        {
            ViewBag.deviceId = deviceName; // "$UVSL-01-0435";
            ViewBag.topicId = topicName; // $TOPIC-ECG-01-01";
            ViewBag.feedId = feedName; // "Waveform1";
            return View("SSEWaveform");
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}