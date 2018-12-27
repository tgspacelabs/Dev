using System;
using System.Collections;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Spacelabs.WaveformSse.Feeds
{
    /// <summary>
    /// WaveformPacketReorderingQueue is intended be used when processsing and incomming stream of
    /// waveform packets.
    /// It outputs an updated stream of packets where each packet has a starting sample number
    /// so that individual samples may be output with one up sequence numbers
    /// It handles:
    ///     Missing Packets (ie packet 9 never arrives)
    ///     Out of order packets (ie packet 9 arrived after packet 10)
    ///     Rollover of incomming sequence numbers
    /// It does not attempt to generate actual timestamps for out going packets/samples
    /// but simple outputs a stream of packets that are in order and marked with the beginning output sequence numbre
    /// for the first sample in the packet.
    /// </summary>
    public class WaveformPacketReorderingQueue : IDisposable
    {
        #region private constants

        private const long UninitializeSequenceNumber = -1;
        private const long UnreasonableLargeGapInSequenceNumbers = 10000;



        #endregion

        #region Private Classes

        private enum SeqType
        {
            ErrorShouldNotHappen,
            InOrder,
            Duplicate,
            EarlyArriving,
            LateArriving,
            TooLate,
            Rollover
        }
        #endregion
        #region Private Properties

        private readonly long _nominalSamplesPerSecond;

        private long _nextStartingSeqNo = 1;

        private long _WaitingForSeqNo = UninitializeSequenceNumber;

        private const int _defaultMaxOutputQueueSize = 30000;
        private int _maxOutputQueueSize;

        private DateTime _lastSampleRead = DateTime.MaxValue;

        private object thisLock = new object();

        private BlockingCollection<RawFeedPacket> _BlockingQueue = new BlockingCollection<RawFeedPacket>(_defaultMaxOutputQueueSize);
        private SortedDictionary<long, RawFeedPacket> _buffer = new SortedDictionary<long, RawFeedPacket>();
        private bool _disposed = false;

        #endregion
        #region Private Computed Properties
        private long NextOutputStartingSeqNo
        {
            get
            {
                long retval = _nextStartingSeqNo;
                _nextStartingSeqNo += SamplesPerPacket;
                return retval;
            }
        }
        private long _minSeqNo
        {
            get
            {

                lock (thisLock)
                {
                    if (_buffer.Count == 0)
                    {
                        return Int32.MinValue;
                    }
                    else
                    {
                        var kvp = _buffer.First();
                        return kvp.Key;
                    }

                }
            }
        }

        private double _nominalMsPerPacket
        {
            get
            {
                double result = ((1.0 / (_nominalSamplesPerSecond / SamplesPerPacket)) * 1000.0);
                return result;
            }
        }

        private TimeSpan _minDataAge;
        #endregion

        #region Public Properties
        public long SamplesPerPacket { get; }

        public int QueueLimit { get; set; }
        public bool IsCanceled { get; private set; }

        public bool IsOverflowed { get; private set; }

        public bool IsComplete
        {
            get
            {
                if (_BlockingQueue.IsCompleted)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        public long DuplicatePackets { get; private set; }
        public static long DuplicatePacketsGlobal { get; private set; }
        public static long LatePackets { get; private set; }
        public static long LatePacketsGlobal { get; private set; }
        public long MissingPackets { get; private set; }
        public static long MissingPacketsGlobal { get; private set; }
        public static long RolloverPacketsGlobal { get; private set; }
        public static long TooLatePacketsGlobal { get; private set; }
        public long TotalPackets { get; private set; }
        public static long TotalPacketsGlobal { get; private set; }

        public double Count => _BlockingQueue.Count;

        #endregion
        #region Constructors
        public WaveformPacketReorderingQueue(int maxOutputQueueSize, TimeSpan minDataAge, long samplesPerSecond, long samplesPerPacket)
        {
            _maxOutputQueueSize = maxOutputQueueSize;
            _minDataAge = minDataAge;
            _BlockingQueue = new BlockingCollection<RawFeedPacket>(_maxOutputQueueSize);
            _nominalSamplesPerSecond = samplesPerSecond;
            SamplesPerPacket = samplesPerPacket;
        }

        ~WaveformPacketReorderingQueue()
        {
            Dispose(false);
        }

        /// <summary>
        /// Dispose - IDisposable implementation
        /// </summary>
        /// <param name="disposing"></param>
        private void Dispose(bool disposing)
        {
            ReleaseUnmanagedResources();
            if (disposing)
            {
                _BlockingQueue?.Dispose();
            }
        }

        #endregion
        #region Public Methods

        /// <summary>
        /// Engueue - In "Normal" operation we simply add the packet to the blocking queue
        ///           (and check for LateArriving packets to trigger "Re-order" behavior
        ///           In "Re-order" mode
        /// </summary>
        /// <param name="packet"></param>
        /// <returns>true if enque succeeded. false if queue overflow</returns>
        public bool Enqueue(RawFeedPacket packet)
        {


            SeqType category = PacketCategory(packet.InSeqNo);

            lock (thisLock)
            {
                // Using object will want to limit size of queue
                // so that a blocked webstream reader can be detected
                if (_BlockingQueue.Count >= _maxOutputQueueSize)
                {
                    // If we use the _BlockingQueue capacity
                    // the queue will block
                    QueueOverflow();
                    return false;
                }



                switch (category)
                {
                    case SeqType.Duplicate:
                        DuplicatePackets++;
                        DuplicatePacketsGlobal++;
                        break;
                    // The sequence numbers from UVSL rollover at 24 bits
                    // So ... output any packets we are holding
                    // and start fresh
                    case SeqType.Rollover:
                        if (_buffer.Count > 0)
                        {
                            // Time to start fresh
                            FlushBuffer();

                            // Let the output processor
                            // know that clock should be reset
                            packet.ClockReset = true;

                            // Now the new packet
                            AddToBuffer(packet);

                            // And reset what seq no we are waiting for
                            _WaitingForSeqNo = packet.InSeqNo + 1;
                            RolloverPacketsGlobal++;
                        }
                        break;

                    //  We got the sequence number we were expecting
                    case SeqType.InOrder:
                        {
                            AddToBuffer(packet);
                            _WaitingForSeqNo = packet.InSeqNo + 1;
                        }
                        break;
                    // We missed some sequence numbers
                    case SeqType.EarlyArriving:
                        {
                            // First fill in missing packets with NoData packet
                            while (_WaitingForSeqNo < packet.InSeqNo)
                            {
                                AddNoDataPacketToBuffer(_WaitingForSeqNo);
                                _WaitingForSeqNo++;
                                MissingPackets++;
                                MissingPacketsGlobal++;
                            }
                            // Now add our new packet
                            AddToBuffer(packet);
                            _WaitingForSeqNo = packet.InSeqNo + 1;
                        }
                        break;

                    case SeqType.LateArriving:
                        {
                            // Packet will replace the NoData packet
                            AddToBuffer(packet);
                            LatePackets++;
                            LatePacketsGlobal++;
                            // Dont update _WaitingForSeqNo
                        }
                        break;

                    // This packet arrived late and we've already moved on and output newer packets
                    // So just drop the packet on the floor
                    case SeqType.TooLate:
                        // Do Nothing
                        TooLatePacketsGlobal++;
                        break;
                }
                TotalPackets++;
                TotalPacketsGlobal++;
                // Now move packets from the beginning of the buffer over to our blocking queue for output until 
                // we are down to our DelayBufferSize
                OutputEligiblePackets();
            }
            return true;

        }

        /// <summary>
        /// NextOutputPacket() - This is blocking call to get the next available packet
        /// </summary>
        /// <returns></returns>
        public RawFeedPacket NextOutputPacket(CancellationToken ct)
        {
            RawFeedPacket packet = null;
            try
            {
                // if (!_BlockingQueue.IsAddingCompleted)
                {
                    packet = _BlockingQueue.Take(ct);
                }
            }
            catch (OperationCanceledException)
            {
                IsCanceled = true;
            }
            catch (InvalidOperationException)
            {
                // Queue has been cancelled
                IsCanceled = true;
            }
            return packet;
        }

        /// <summary>
        /// Cancel() - Used to indicate that no further input is to be processed
        /// </summary>
        public void Cancel()
        {
            if (!_BlockingQueue.IsAddingCompleted)
            {
                _BlockingQueue.CompleteAdding();
            }
            IsCanceled = true;
        }

        public void MarkCompleteForAdding()
        {
            _BlockingQueue.CompleteAdding();
        }

        public IEnumerable<RawFeedPacket> GetConsumingEnumerable()
        {
            return (_BlockingQueue.GetConsumingEnumerable());

        }
        #endregion
        #region Private Methods
        private SeqType PacketCategory(long seqNo)
        {
            if (_WaitingForSeqNo == UninitializeSequenceNumber)
            {
                _WaitingForSeqNo = seqNo + 1;
                return SeqType.InOrder;
            }
            else if (seqNo == _WaitingForSeqNo - 1)
            {
                return SeqType.Duplicate;
            }
            else if (seqNo < _WaitingForSeqNo)
            {
                if ((_WaitingForSeqNo - seqNo) > UnreasonableLargeGapInSequenceNumbers)
                {
                    // The sequence numbers from UVSL rollover at 24 bits
                    return SeqType.Rollover;
                }
                else if (seqNo > _minSeqNo)
                {
                    // This packet arrived late but we have not output it yet
                    return SeqType.LateArriving;
                }
                else
                {
                    // This packet arrived late. 
                    // But we already output newer packets. 
                    // Sorry packet you are getting dropped
                    return SeqType.TooLate;
                }
            }
            else if (seqNo == _WaitingForSeqNo)
            {
                return SeqType.InOrder;
            }
            else // (already checked < and =) if (seqNo > _WaitingForSeqNo)
            {
                // Ooops we were not expecting this packet yet

                return SeqType.EarlyArriving;
            }
        }

        private void OutputOldestPacket()
        {
            RawFeedPacket packet = null;

            lock (thisLock)
            {
                long seqNo = _minSeqNo;
                packet = _buffer[seqNo];
                _buffer.Remove(seqNo);

            }

            if (!IsCanceled)
            {
                _BlockingQueue.Add(packet);
            }
        }
        private void FlushBuffer()
        {
            while (_buffer.Count > 0)
            {
                OutputOldestPacket();
            }
        }
        private void AddToBuffer(RawFeedPacket packet)
        {

            lock (thisLock)
            {
                if (!_buffer.ContainsKey(packet.InSeqNo))
                {
                    packet.StartingOutSeqNo = NextOutputStartingSeqNo;
                }
                else
                {
                    // We are replacing a packet with a late arriving packet
                    // so get the already allocated starting output seq no
                    packet.StartingOutSeqNo = _buffer[packet.InSeqNo].StartingOutSeqNo;
                }
                _buffer[packet.InSeqNo] = packet;

            }
        }

        private void AddNoDataPacketToBuffer(long seqNo)
        {
            DateTime packetTime = DateTime.UtcNow;
            packetTime = _buffer[seqNo - 1].ArrivalTime + TimeSpan.FromMilliseconds(_nominalMsPerPacket);
            RawFeedPacket emptyDataPacket = RawFeedPacket.NewNoDataPacket(seqNo, SamplesPerPacket);
            emptyDataPacket.ArrivalTime = packetTime;
            AddToBuffer(emptyDataPacket);
        }

        private void OutputEligiblePackets()
        {
            if (_buffer.Count < 3)
            {
                return;
            }
            while ((_buffer.Last().Value.ArrivalTime - _buffer.First().Value.ArrivalTime) > _minDataAge)
            {
                OutputOldestPacket();
            }

        }

        private void QueueOverflow()
        {
            IsOverflowed = true;
            Cancel();
        }
        #endregion


        private void ReleaseUnmanagedResources()
        {
            // TODO release unmanaged resources here
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}
