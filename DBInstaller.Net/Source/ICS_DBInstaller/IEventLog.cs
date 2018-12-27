using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;

namespace Spacelabs.DBInstaller
{
    public interface IEventLog
    {
        /// <summary>
        /// Writes the entry to the event log with specified type
        /// </summary>
        /// <param name="message"></param>
        /// <param name="type"></param>
        void LogEvent(string message, EventLogEntryType type);                          
    }
}
