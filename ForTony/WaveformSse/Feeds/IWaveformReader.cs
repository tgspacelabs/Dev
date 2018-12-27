// ------------------------------------------------------------------------------------------------
// File: ISalishFeed.cs
// © Copyright 2013 Spacelabs Healthcare, Inc.
//
// This document contains proprietary trade secret and confidential information
// which is the property of Spacelabs Healthcare, Inc.  This document and the
// information it contains are not to be copied, distributed, disclosed to others,
// or used in any manner outside of Spacelabs Healthcare, Inc. without the prior
// written approval of Spacelabs Healthcare, Inc.
// ------------------------------------------------------------------------------------------------
//
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spacelabs.WaveformSse.Feeds
{

    // ------------------------------------------------------------------------------------------------
    // File: ISalishFeed.cs
    // © Copyright 2013 Spacelabs Healthcare, Inc.
    //
    // This document contains proprietary trade secret and confidential information
    // which is the property of Spacelabs Healthcare, Inc.  This document and the
    // information it contains are not to be copied, distributed, disclosed to others,
    // or used in any manner outside of Spacelabs Healthcare, Inc. without the prior
    // written approval of Spacelabs Healthcare, Inc.
    // ------------------------------------------------------------------------------------------------
    //

    public class RawFeedPacketEventArgs : EventArgs
    {
        public RawFeedPacket Packet { get; private set; }
        public RawFeedPacketEventArgs(RawFeedPacket packet)
        {
            Packet = packet;
        }
    }

    public delegate void RawFeedPacketEventHandler(object sender, RawFeedPacketEventArgs args);

    internal interface IWaveformReader 
    {
        event EventHandler<RawFeedPacketEventArgs> WaveformDataArrived;

    }
}
