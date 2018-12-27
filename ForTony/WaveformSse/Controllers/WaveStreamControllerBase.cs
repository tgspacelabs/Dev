using System;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading;
using System.Web.Http;

using Spacelabs.WaveformSse.Logging;
using Spacelabs.WaveformSse.Feeds;

//using Metrics;
//using Spacelabs.SLNI.CDL.FeedReaders.WCF;
//using Spacelabs.SLNI.MetricReporting;

namespace Spacelabs.WaveformSse.Controllers
{
    /// <inheritdoc />
    /// <summary>
    /// WaveStreamControllerBase - Encapsulates responsiblities for Waveform Stream handling
    /// </summary>
    public class WaveStreamControllerBase : DataStreamControllerBase<RawFeedPacket>
    {
        /// <summary>
        /// SampleRateKey - MetaDataIndex
        /// </summary>
        protected const string SampleRateKey = "SampleRate";
        /// <summary>
        /// SampleSetsRateKey - MetaDataIndex
        /// </summary>
        protected const string SampleSetsRateKey = "SampleSetsPerSecond";

        /// <summary>
        /// DeviceId - Guid of Device of waveform we are reporting on
        /// </summary>
        protected Guid DeviceId; // Currently only used for logging
        /// <summary>
        /// TopicId - Guid of Topic of waveform we are reporting on
        /// </summary>
        protected Guid TopicId; // Currently only used for logging
        /// <summary>
        /// FeedId - Guid of Feed of waveform we are reporting on
        /// </summary>
        protected Guid FeedId;

        /// <summary>
        /// SamplesPerSec
        /// </summary>
        protected int SamplesPerSec;
        /// <summary>
        /// PacketsPerSec
        /// </summary>
        protected int PacketsPerSec;
        /// <summary>
        /// SamplesPerPacket
        /// </summary>
        protected int SamplesPerPacket => SamplesPerSec / PacketsPerSec;

        /// <summary>
        /// TotalPackets
        /// </summary>
        protected long TotalPackets => RawPacketQueue?.TotalPackets ?? 0;

        private WaveformFeedReader _feedReader;
        private bool _disposed = false;

        /// <summary>
        /// RawPacketQueue - Items are added when notified of feed update Items are removed on output to stream
        /// </summary>
        protected WaveformPacketReorderingQueue RawPacketQueue;
        /// <summary>
        /// OutClock - Used to generate output timestamps
        /// </summary>
        protected WaveformOutputClock OutClock;
        /// <summary>
        /// PacketDriftTimer - metric
        /// </summary>
        //protected Metrics.Timer PacketDriftTimer;
        private static bool _staticMetricsInitialized;

        /// <inheritdoc />
        public WaveStreamControllerBase(string dataType)
            : base(dataType)
        {
            InitializeStaticMetrics();
        }

        /// <summary>
        /// WaveStreamControllerBase - destructor
        /// </summary>
        ~WaveStreamControllerBase()
        {
            Dispose(false);
        }
        /// <inheritdoc />
        protected override void Dispose(bool disposing)
        {
            if (_disposed)
                return;

            if (disposing)
            {
                //MetricsAccess.Instance.ShutdownSubContext("TotalPackets", FriendlyDataFeedName);
                //MetricsAccess.Instance.ShutdownSubContext("ObservedSampleRate", FriendlyDataFeedName);
                //MetricsAccess.Instance.ShutdownSubContext($"{DataType}OutQueueCount", FriendlyDataFeedName);
                //MetricsAccess.Instance.ShutdownSubContext($"{DataType}MaxOutQueueCount", FriendlyDataFeedName);
                RawPacketQueue?.Dispose();
                RawPacketQueue = null;
            }

            // Free any unmanaged objects here.
            //

            _disposed = true;
            // Call base class implementation.
            base.Dispose(disposing);
        }

        /// <summary>
        /// InitializeStaticMetrics - These metrics are system wide and must only be initialized once
        /// </summary>
        protected void InitializeStaticMetrics()
        {
            if (_staticMetricsInitialized) return;
            _staticMetricsInitialized = true;

            //MetricsAccess.Instance.GaugeInit("LatePackets", "All", () => WaveformPacketReorderingQueue.LatePackets, Unit.Items);
            //MetricsAccess.Instance.GaugeInit("TooLatePackets", "All", () => WaveformPacketReorderingQueue.TooLatePacketsGlobal, Unit.Items);
            //MetricsAccess.Instance.GaugeInit("DuplicatePackets", "All", () => WaveformPacketReorderingQueue.DuplicatePacketsGlobal, Unit.Items);
            //MetricsAccess.Instance.GaugeInit("MissingPackets", "All", () => WaveformPacketReorderingQueue.MissingPacketsGlobal, Unit.Items);
            //MetricsAccess.Instance.GaugeInit("TotalPackets", "All", () => WaveformPacketReorderingQueue.TotalPacketsGlobal, Unit.Items);

        }

        /// <inheritdoc />
        protected override void InitializeFeeds()
        {
            base.InitializeFeeds();
            FullDataFeedName = $"{DeviceId} {TopicId} {FeedId}";
            FriendlyDataFeedName =
                $"{GuidNameRepository.ReplaceIdsWithNamesOnly(DeviceId.ToString())} {GuidNameRepository.ReplaceIdsWithNamesOnly(TopicId.ToString())} {GuidNameRepository.ReplaceIdsWithNamesOnly(FeedId.ToString())}";
            FriendlyDataFeedName = FriendlyDataFeedName.Replace("{", "").Replace("}", "").Replace("=", "").Replace("<", " ");

            //// Get the feed reader for the requested feed
            //IXNetDevice xd = null;
            //if (CdiHostService.Instance.Devices.TryGetValue(DeviceId, out xd))
            //{
            //    _feedReader = xd.Topics[TopicId].Feeds[FeedId].Readers.First() as
            //        WaveformFeedReader;
            //}


            if (_feedReader == null)
            {
                Logger.Log(LogLevel.ERROR, "WaveformStream {0} **** NULL FeedReader ***** for: GetWaveformStream", FeedId);
                throw new HttpResponseException(Request.CreateErrorResponse(HttpStatusCode.NotFound, "Requested Feed Not Available"));
            }


            //FriendlyDataFeedName = $"{xd?.Name} {xd?.Topics[TopicId].Name} {xd?.Topics[TopicId].Feeds[FeedId].Name} ({Instance})";
            FriendlyDataFeedName = $"{DeviceId} {TopicId} {FeedId} ({Instance})";
            FriendlyDataFeedName = FriendlyDataFeedName.Replace("$", "");
            //MetricsAccess.Instance.GaugeInit("ObservedSampleRate", FriendlyDataFeedName, () => Math.Abs(OutClock.ComputedSamplesPerSecond), Unit.Items);
            //PacketDriftTimer = MetricsAccess.Instance.TimerAccess("PacketTimeDrift", FriendlyDataFeedName, Unit.Requests);
            SamplesPerSec = (int)_feedReader.FeedMetaData[SampleRateKey];
            PacketsPerSec = (int)_feedReader.FeedMetaData[SampleSetsRateKey];

            var minDataAgeMs = 200;
            var dataAgeCfgSetting = ConfigurationManager.AppSettings["WebWaveMinDataAge"];
            if (!string.IsNullOrEmpty(dataAgeCfgSetting))
            {
                int.TryParse(dataAgeCfgSetting, out minDataAgeMs);
            }
            //RawPacketQueue = new WaveformPacketReorderingQueue(BlockingQueueSize, TimeSpan.FromMilliseconds(minDataAgeMs), SamplesPerSec, SamplesPerPacket);
            //OutClock = new WaveformOutputClock(SamplesPerSec, SamplesPerPacket);

            //MetricsAccess.Instance.GaugeInit("TotalPackets", FriendlyDataFeedName, () => TotalPackets, Unit.Items);

            // Connect to the FeedReader to get data

            _feedReader.WaveformDataArrived += NotificationHandler;

        }

        /// <summary>
        /// GetUpdates - Encapsulates the common responsibilities of WaveStream (sse and non-sse) controllers
        /// </summary>
        /// <param name="deviceId"></param>
        /// <param name="topicId"></param>
        /// <param name="feedId"></param>
        /// <param name="cancellationToken"></param>
        /// <returns></returns>
        public virtual HttpResponseMessage GetUpdates(Guid deviceId, Guid topicId, Guid feedId, CancellationToken cancellationToken)
        {
            DeviceId = deviceId;
            TopicId = topicId;
            FeedId = feedId;

            //PrereqChecker.ThrowIfFeedDoesNotExist(deviceId, topicId, feedId);

            return GetUpdatesInternal(cancellationToken);
        }

        private void NotificationHandler(object sender, RawFeedPacketEventArgs notification)
        {
            //using (CdiHostService.Instance.MetricsAccessor.TimerAccess("EnqueWaveformPacket", "", Unit.Requests).NewContext())
            {
                if (!RawPacketQueue.Enqueue(notification.Packet))
                {
                    ChildCancellationTokenSource.Cancel();
                    return;
                }
                // For metrics only
                var currentQSize = RawPacketQueue.Count;

                if (!(currentQSize > 10)) return;

                if (!MaxQueueSize.HasValue)
                {
                    MaxQueueSize = currentQSize;
                    // Collect Metrics on the size of Output Queue. High count will indicate that client is not keeping up with reading the data

                    //MetricsAccess.Instance.GaugeInit($"{DataType}OutQueueCount", FriendlyDataFeedName, () => RawPacketQueue?.Count ?? 0, Unit.Items);
                    //MetricsAccess.Instance.GaugeInit($"{DataType}MaxOutQueueCount", FriendlyDataFeedName, () => MaxQueueSize.Value, Unit.Items);
                }
                else if (currentQSize > MaxQueueSize)
                {
                    MaxQueueSize = currentQSize;
                }
            }
        }

        /// <inheritdoc />
        protected override RawFeedPacket NextPacket(CancellationToken ct)
        {
            return RawPacketQueue.NextOutputPacket(ct);
        }

        /// <inheritdoc />
        protected override bool OutputQueueOverflow()
        {
            return RawPacketQueue.IsOverflowed;
        }

        /// <inheritdoc />
        protected override void StopDataFeeds()
        {
            if (_feedReader == null) return;

            //Unsubscribe from the event WaveformDataArrived
            _feedReader.WaveformDataArrived -= NotificationHandler;
            _feedReader = null;

        }


    }
}