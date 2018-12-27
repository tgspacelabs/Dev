using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Http;
using System.Threading;
using System.Web.Http;
using Metrics;
using Spacelabs.SLNI.CDL.FeedReaders.WCF;
using Spacelabs.SLNI.MetricReporting;
using Spacelabs.XNetDataContracts;

namespace Spacelabs.SLNI.WebAPI.Controllers
{
    /// <summary>
    /// WaveformSSEController - Handles requests for FeedWaveformSSE streams
    /// </summary>
    /// <inheritdoc />
    [Authorize(Roles = "XNRest")]
    public class WaveformSSEController : WaveStreamControllerBase
    {
        private WaveformOutputClock _outClock = null;
        private DateTime _lastMetricsLogged = DateTime.MinValue;
        private bool _disposed = false;

        /// <inheritdoc />
        /// <summary>
        /// WaveformSSEController - ctor
        /// </summary>
        public WaveformSSEController()
            : base("WaveformSSE")
        { }

        /// <summary>
        /// WaveformSSEController - destructor
        /// </summary>
        ~WaveformSSEController()
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
            }

            // Free any unmanaged objects here.
            //

            _disposed = true;
            // Call base class implementation.
            base.Dispose(disposing);
        }
        /// <summary>
        /// GetUpdates - Provides the actual entry point to support rest api for FeedWaveformSSE
        /// </summary>
        /// <param name="deviceName"></param>
        /// <param name="topicName"></param>
        /// <param name="feedName"></param>
        /// <param name="cancellationToken"></param>
        /// <returns></returns>
        [Route("rest/Devices/{deviceName}/Topics/{topicName}/Feeds/{feedName}/FeedWaveformSSE")]
        public HttpResponseMessage GetUpdates(string deviceName, string topicName, string feedName, CancellationToken cancellationToken)
        {
            var deviceId = Helpers.GetDeviceId(deviceName);
            var topicId = Helpers.GetTopicInstanceId(deviceName, topicName);
            var feedId = Helpers.GetFeedId(deviceId, topicId, feedName);

            return GetUpdates(deviceId, topicId, feedId, cancellationToken);
        }
        /// <inheritdoc />
        /// <summary>
        /// GetUpdates - Provides the actual entry point to support rest api for FeedWaveformSSE
        /// </summary>
        /// <param name="deviceId"></param>
        /// <param name="topicId"></param>
        /// <param name="feedId"></param>
        /// <param name="cancellationToken"></param>
        /// <returns></returns>
        [Route("rest/Devices/{deviceId:guid}/Topics/{topicId:guid}/Feeds/{feedId:guid}/FeedWaveformSSE")]
        public override HttpResponseMessage GetUpdates(Guid deviceId, Guid topicId, Guid feedId, CancellationToken cancellationToken)
        {
            return base.GetUpdates(deviceId, topicId, feedId, cancellationToken);
        }

        /// <inheritdoc />
        /// <summary>
        /// InitializeFeeds
        /// </summary>
        protected override void InitializeFeeds()
        {
            base.InitializeFeeds();
            _outClock = new WaveformOutputClock(SamplesPerSec, SamplesPerPacket);
        }

        /// <inheritdoc />
        protected override void WritePacketToStream(RawFeedPacket packet, Stream stream, StreamWriter sw, bool firstPacket)
        {
            sw.Write($"data: ");
            sw.Flush();

            using (CdiHostService.Instance.MetricsAccessor.TimerAccess("WaveformTimeStampAndSerialize", "", Unit.Requests).NewContext())
            {
                var sampleOutList = _outClock.OutputSampleList(packet);

                // Collect metrics on difference between PacketArrival Time and Computed Sample Output time ("Drift")
                // Individual this will be irratic but the average is a meaningful measure of how accurately we are reporting 
                long ms = (long)packet.Drift;
                MetricsAccess.Instance.TimerAccess("PacketTimeDrift", FriendlyDataFeedName, Unit.Requests).Record(ms, TimeUnit.Milliseconds);

                // write to the stream
                // Encode as ascii
                // Framework will encode the Ascii to UTF8. If we try to do so here output will be incorrect
                JsonStreamFormatter.WriteToStream(typeof(List<WaveformSample>), sampleOutList, stream, System.Text.Encoding.ASCII);

            }

            sw.Write("\n\n");
            sw.WriteLine();
            sw.Flush();
            if ((DateTime.UtcNow - _lastMetricsLogged).TotalSeconds > 60.0)
            {
                Logger.Log(LogLevel.INFO, $"{FriendlyDataFeedName} Metrics: SampleRate: {_outClock.ComputedSamplesPerSecond} AvgDrift: {_outClock.AverageDriftMs} DriftCorrection: {_outClock.DriftCorrectionMs} MissingPackets: {RawPacketQueue.MissingPackets} DupePackets: {RawPacketQueue.DuplicatePackets} LatePackets: {WaveformPacketReorderingQueue.LatePackets}");
                _lastMetricsLogged = DateTime.UtcNow;
            }

        }
    }
}
