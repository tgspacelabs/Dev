using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using Spacelabs.XNetDataContracts;

namespace Spacelabs.WaveformSse.Feeds
{
    /// <summary>
    /// WaveformOutputClock is used to assign output timestamps 
    /// to outgoing waveform samples
    /// 
    /// Usage:
    ///             List<WaveformSample> sampleOutList = new List<WaveformSample>();
    ///
    ///            outClock.UpdateClockParameters(packet);
    ///            _seqNo = packet.StartingOutSeqNo;
    ///
    ///            foreach (uint s in packet.Samples)
    ///            {
    ///                double timeInMs = outClock.OutTimeInMsSince1970(_seqNo);
    ///                sampleOutList.Add(new WaveformSample(s, (long)timeInMs, _seqNo++));
    ///            }
    /// 
    /// </summary>
    public class WaveformOutputClock
    {
        #region Private properties

        /// <summary>
        /// RecentPackets is used to compute the Average Drift of recent packets
        /// so that can adjust the computed output times to adjust for the drift
        /// </summary>
        private List<RawFeedPacket> RecentPackets = new List<RawFeedPacket>();

        /// <summary>
        /// What method to use to compute the observed sample rate
        /// </summary>
        private enum ComputeSampleRateMethod
        {
            UseNominal, // Use the Nominal Sample Rate with no adjustment
            UseWindow, // Use the window in RecentPackets to compute the observed sample rate

            UsePacketZero // Compute Observed Sample rate using the time and sequence number of
            // the first packet we processed and the latest packet (*** Works the best ***)
        };

        private ComputeSampleRateMethod _howToDetermineRate = ComputeSampleRateMethod.UseNominal;
        private bool _doDriftAdjustment = true;

        /// <summary>
        /// The "Magic Numbers" that seem to work best
        /// </summary>
        private double _maxPercentRateAdjustment = 25.0;

        private double _driftAdjustThreshold = 500; // ms
        private double _driftAdjustPercentOfDrift = 0.005;
        private double _maxDriftAdjustPercentOfMsPerSample = 5.0;

        private bool _initialized = false;
        private double _sumOfDrifts = 0;

        #endregion

        #region Public properties

        public long MaxHistoryPackets { get; private set; } = 200;
        public long MinHistoryPacketsToComputeSampleSPerSeconds { get; private set; } = 2000;
        public long MinHistoryPacketsToAdjustDrift => MaxHistoryPackets;

        /// <summary>
        /// TZeroMsSince1970 and PacketZero are used in the UsePacketZero method of computing Observed Sample Rate
        /// They are initialized on the first UpdateClockParameters call
        /// </summary>
        public double TZeroMsSince1970 { get; set; } = 0.0;

        public RawFeedPacket PacketZero { get; set; } = null;


        public double NominalMsPerSample => (1.0 / NominalSamplesPerSecond) * 1000.0;

        public double NominalSamplesPerSecond { get; private set; }
        public double SamplesPerPacket { get; set; }

        public long LastOutputSeqNo { get; private set; } = -1;
        public double LastOutputMsSince1970 { get; private set; } = -1.0;

        public double ComputedSamplesPerSecond { get; private set; }
        public double ComputedMsPerSample => (1.0 / ComputedSamplesPerSecond) * 1000.0;

        public double DriftCorrectionMs { get; private set; } = 0.0;

        public double CurrentDriftMs
        {
            get
            {
                double result = 0;
                if (RecentPackets.Count > 0)
                {
                    result = RecentPackets.Last().Drift;
                }
                return result;
            }
        }

        public double AverageDriftMs
        {
            get
            {
                double result = 0;
                if (RecentPackets.Count > 2)
                {
                    result = _sumOfDrifts / RecentPackets.Count;
                }
                return result;
            }
        }



        #endregion

        #region Constructors

        public WaveformOutputClock(double samplesPerSecond, double samplesPerPacket)
        {
            SamplesPerPacket = samplesPerPacket;
            NominalSamplesPerSecond = samplesPerSecond;
            ComputedSamplesPerSecond = NominalSamplesPerSecond;
            InitializeAdjustmentParameters();
        }


        #endregion

        #region Public Methods

        public void Reset()
        {
            _initialized = false;
        }

        public void UpdateClockParameters(RawFeedPacket packet)
        {
            // Reset on "Rollover"
            if (packet.ClockReset)
            {
                Reset();
            }
            // If not yet initialized do so
            if (!_initialized)
            {
                Initialize(packet);
            }
            // Trim recent history
            while (RecentPackets.Count > MaxHistoryPackets)
            {
                RemovePacketFromRecentHistory(RecentPackets.First());
            }


            // Set the output time for the packets first packet
            // (This is only used as a packet property when updating these clock parmeters)
            packet.OutTimeInMsSince1970ForFirstSample = OutTimeInMsSince1970(packet.StartingOutSeqNo);

            // Add packet to recent history
            AddPacketToRecentHistory(packet);

            // Adjust the SampleRate as needed
            ComputeSampleRate();

            // Adjust the DriftCorrection as needed
            ComputeDriftCorrection(packet);
        }

        public double AdjustedMsPerSample()
        {
            double result = ComputedMsPerSample;
            result += DriftCorrectionMs;
            return result;
        }

        public double OutTimeInMsSince1970(long outSeqNo)
        {
            long deltaSeqNo = outSeqNo - LastOutputSeqNo;
            double result = LastOutputMsSince1970 + (deltaSeqNo * AdjustedMsPerSample());
            LastOutputMsSince1970 = result;
            LastOutputSeqNo = outSeqNo;
            return result;
        }

        public List<WaveformSample> OutputSampleList(RawFeedPacket inPacket)
        {
            List<WaveformSample> retList = new List<WaveformSample>();

            UpdateClockParameters(inPacket);

            long _seqNo = inPacket.StartingOutSeqNo;

            foreach (uint s in inPacket.Samples)
            {
                double timeInMs = OutTimeInMsSince1970(_seqNo);
                retList.Add(new WaveformSample(s, (long)timeInMs, _seqNo++));
            }

            return retList;
        }

        #endregion
        #region Private Methods
        private void RemovePacketFromRecentHistory(RawFeedPacket packet)
        {
            _sumOfDrifts = _sumOfDrifts - packet.Drift;
            RecentPackets.Remove(packet);
        }

        private void AddPacketToRecentHistory(RawFeedPacket packet)
        {
            _sumOfDrifts = _sumOfDrifts + packet.Drift;
            RecentPackets.Add(packet);
        }

        private void Initialize(RawFeedPacket packet)
        {
            TZeroMsSince1970 = (packet.ArrivalTime - XnGlobalConstants.SLOriginTime).TotalMilliseconds;
            LastOutputSeqNo = packet.StartingOutSeqNo;
            LastOutputMsSince1970 = TZeroMsSince1970;
            PacketZero = packet;
            RecentPackets = new List<RawFeedPacket>();
            _sumOfDrifts = 0;
            _initialized = true;
        }
        private void ComputeSampleRate()
        {
            RawFeedPacket last = RecentPackets.Last();
            RawFeedPacket first = PacketZero;
            bool adjust = false;
            switch (_howToDetermineRate)
            {
                case ComputeSampleRateMethod.UseNominal:
                    break;
                case ComputeSampleRateMethod.UsePacketZero:
                    {
                        first = PacketZero;
                        if (last.InSeqNo - first.InSeqNo > MinHistoryPacketsToComputeSampleSPerSeconds)
                        {
                            adjust = true;
                        }
                    }
                    break;
                case ComputeSampleRateMethod.UseWindow:
                    if (RecentPackets.Count >= MinHistoryPacketsToComputeSampleSPerSeconds)
                    {
                        adjust = true;
                        first = RecentPackets.First();
                    }
                    break;
                default:
                    break;
            };
            if (adjust)
            {
                long totalPackets = last.InSeqNo - first.InSeqNo;
                double deltaMs = (last.ArrivalTime - XnGlobalConstants.SLOriginTime).TotalMilliseconds - (first.ArrivalTime - XnGlobalConstants.SLOriginTime).TotalMilliseconds;
                double computedValue = totalPackets * SamplesPerPacket / (deltaMs / 1000.0);

                // Limit range 
                double upper = NominalSamplesPerSecond + _maxPercentRateAdjustment * NominalSamplesPerSecond / 100;
                double lower = NominalSamplesPerSecond - _maxPercentRateAdjustment * NominalSamplesPerSecond / 100;
                computedValue = Math.Min(computedValue, upper);
                computedValue = Math.Max(computedValue, lower);
                ComputedSamplesPerSecond = computedValue;
            }
        }

        private void ComputeDriftCorrection(RawFeedPacket packet)
        {
            if (_doDriftAdjustment && packet.InSeqNo % 100 == 0)
            {
                if (RecentPackets.Count >= MinHistoryPacketsToAdjustDrift)
                {
                    double absAvgDrift = Math.Abs(AverageDriftMs);
                    if (absAvgDrift > _driftAdjustThreshold)
                    {
                        DriftCorrectionMs = _driftAdjustPercentOfDrift * absAvgDrift / 100;
                        double upperLimit = _maxDriftAdjustPercentOfMsPerSample * NominalMsPerSample / 100;
                        DriftCorrectionMs = Math.Min(upperLimit, DriftCorrectionMs);
                        if (AverageDriftMs > 0)
                        {
                            DriftCorrectionMs *= -1.0;
                        }
                    }
                    else
                    {
                        DriftCorrectionMs = 0.0;
                    }
                }
            }

        }
        private double MsDriftForPacket(RawFeedPacket packet)
        {
            return packet.Drift;
        }

        private double GetConfigValue(string name, double defaultValue)
        {
            double value = defaultValue;
            string cfgSetting = ConfigurationManager.AppSettings[name];
            if (!string.IsNullOrEmpty(cfgSetting))
            {
                Double.TryParse(cfgSetting, out value);
            }
            return value;
        }
        private void InitializeAdjustmentParameters()
        {
            MinHistoryPacketsToComputeSampleSPerSeconds = (int)GetConfigValue("Waveform.Clock.Rate.MinPacketsToCompute", 2000);
            _maxPercentRateAdjustment = GetConfigValue("Waveform.Clock.Rate.MaxPercentAdj", 25.0);
            MaxHistoryPackets = (int)GetConfigValue("WaveformClock.DriftAdj.HistorySize", 200);
            _driftAdjustThreshold = GetConfigValue("Waveform.Clock.DriftAdj.ThresholdMs", 500);
            _driftAdjustPercentOfDrift = GetConfigValue("Waveform.Clock.DriftAdj.PercentOfDrift", 0.05);
            _maxDriftAdjustPercentOfMsPerSample = GetConfigValue("Waveform.Clock.DriftAdj.MaxPerCentOfMsPerSample", 5.0);
        }
        #endregion




    }
}
