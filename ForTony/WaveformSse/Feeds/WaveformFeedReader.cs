using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Spacelabs.WaveformSse.Feeds
{
    public class WaveformFeedReader : IWaveformReader
    {
        public event EventHandler<RawFeedPacketEventArgs> WaveformDataArrived;
        public IDictionary<string, object> FeedMetaData = new Dictionary<string, object>();
    }
}