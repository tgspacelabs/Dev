using System;
using Spacelabs.XNetDataContracts;

namespace Spacelabs.WaveformSse.Feeds
{
    /// <summary>
    /// RawFeedPacket is used to move incoming waveform sample packets through
    /// XprezzNet.
    /// Originally it is created with:
    ///     ArrivalTime
    ///     InSeqNo
    ///     Samples
    /// 
    /// If the InSeqNo rolls over then the WaveformPacketReorderingQueue will set "ClockReset" to
    /// inform the WaveformOutputClock that the rollover occured.
    /// 
    /// The WaveformPacketReorderingQueue fills in the StartingOutSeqNo so that the samples
    /// will be output with one up output sequence numbers
    /// 
    /// NewNoDataPacket is included to simplify and encapsulate created a new RawFeedPacket
    /// with NoData samples. These packets are used to fill in for missing packets.
    /// </summary>
    public class RawFeedPacket
    {

        /// <summary>
        /// The format of each sample is described in SalishUSL.g.cs
        /// </summary>
        private uint[] _samples;

        /// <summary>
        /// Arrival time is initialized when the RawFeedPacket is created at the
        /// time the packet is read by the WaveformFeedReader
        /// </summary>
        public DateTime ArrivalTime { get; set; } = DateTime.UtcNow;
        /// <summary>
        /// OutTimeInMsSince1970ForFirstSample is set by the WaveformOutputClock and
        /// reflects the output timestamp used for the first sample in the packet
        /// </summary>
        public double OutTimeInMsSince1970ForFirstSample { get; set; } = 0;

        /// <summary>
        /// Drift is the difference in time for this packet between the ArrivalTime and OutTimeInMsSince1970ForFirstSample
        /// Due to processing jitter and other factors it is not very meaningful on its own for one packet
        /// But the average Drift over an interval of several seconds can be used to adjust the parameters of
        /// the WaveformOutputClock.
        /// </summary>
        public double Drift => OutTimeInMsSince1970ForFirstSample - (ArrivalTime - XnGlobalConstants.SLOriginTime).TotalMilliseconds;
        /// <summary>
        /// InSeqNo reflects the sequence number assigned by source (Monitor or XTR) to the original packet of samples
        /// </summary>
        public long InSeqNo { get; set; }
        /// <summary>
        /// StartingOutSeqNo reflects the output sequence number to be used for the first sample in the packet
        /// </summary>
        public long StartingOutSeqNo { get; set; } = -1;

        /// <summary>
        /// ClockReset is set by the WaveformPacketReorderingQueue to indicate that the incoming sequence numbers have
        /// "RolledOver"
        /// </summary>
        public bool ClockReset { get; set; } = false;

        /// <summary>
        /// The format of each sample is described in SalishUSL.g.cs
        /// </summary>
        public uint[] Samples
        {
            get { return _samples; }
            private set
            {
                _samples = new UInt32[value.Length];
                Array.Copy(value, _samples, value.Length);
            }
        }
        /// <summary>
        /// RawFeedPacket(long inSeqNo, uint[] samples) is the
        /// constructor usually used when initializing a packet with new
        /// samples from an input feed
        /// </summary>
        /// <param name="inSeqNo"></param>
        /// <param name="samples"></param>
        public RawFeedPacket(long inSeqNo, uint[] samples)
        {
            InSeqNo = inSeqNo;
            Samples = samples;
        }
        /// <summary>
        /// NewNoDataPacket allows creation of a packet of "NoData" samples
        /// with a given sequence number
        /// </summary>
        /// <param name="inSeqNo"></param>
        /// <param name="samplesPerPacket"></param>
        /// <returns></returns>
        public static RawFeedPacket NewNoDataPacket(long inSeqNo, long samplesPerPacket)
        {
            uint[] emptySamples = new UInt32[samplesPerPacket];
            return new RawFeedPacket(inSeqNo, emptySamples);
        }
    }
}
