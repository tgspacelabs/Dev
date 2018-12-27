using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Spacelabs.WaveformSse.Feeds
{
    public class Helpers
    {
        internal static Guid GetDeviceId(string deviceName)
        {
            return Guid.Empty;
        }

        internal static Guid GetTopicInstanceId(string deviceName, string topicName)
        {
            return Guid.Empty;
        }

        internal static Guid GetFeedId(object deviceId, object topicId, string feedName)
        {
            return Guid.Empty;
        }
    }
}