// ------------------------------------------------------------------------------------------------
// File: EventLogger.cs
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
using System.Diagnostics;
using System.Threading;

namespace Spacelabs.WaveformSse.Logging
{
    internal static class EventLogger
    {
        static bool _SourceOk = false;

        static EventLogger()
        {
            try
            {
                if (!EventLog.SourceExists(EventLogSource))
                {
                    EventLog.CreateEventSource(EventLogSource, EventLogCategory);
                }

                _SourceOk = true;
            }
            catch (Exception)
            {
                //
            }
        }

        public const string EventLogSource = "XprezzNet";
        public const string EventLogCategory = "Application";

        public static void LogData(string messageString, EventCategory appEventCategory, EventId appEventId = EventId.General, EventLogEntryType entryType = EventLogEntryType.Information)
        {
            if (_SourceOk)
            {
                var message = "[ ProcID = " + Process.GetCurrentProcess().Id + "\t\t ThreadId = " + Thread.CurrentThread.ManagedThreadId + "]\n";
                message += messageString;

                EventLog.WriteEntry(EventLogSource, message, entryType, (int)appEventId, (short)appEventCategory);
            }
        }


        public enum EventCategory
        {
            Cdi = 0,
            Alarm,
            Waveform,
            Vitals,
            Configuration,
            Licensing,
            Unexpected,
            Database,       // Events related to Db connection and query execution
            SLNI,           // Expected SLNI events
            DataLoader,     // Expected DataLoader events
        }

        public enum EventId
        {
            General = 1,
            DevelopmentIssue,
            NeedsAttention,
            MayNeedAttention
        }
    }
}

