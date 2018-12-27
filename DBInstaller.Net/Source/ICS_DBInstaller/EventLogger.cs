using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;

namespace Spacelabs.DBInstaller
{
    public class EventLogger : IEventLog, IDisposable
    {
        /// <summary>
        /// System eventlog
        /// </summary>
        readonly EventLog systemEventLogger = null;
        /// <summary>
        /// C'tor
        /// </summary>
        public EventLogger()
        {
            systemEventLogger = new EventLog("Spacelabs", Environment.MachineName, "Spacelabs.DBInstaller");
        }
        /// <summary>
        /// Writes the entry to the event log with specified type
        /// </summary>
        /// <param name="message"></param>
        /// <param name="type"></param>
        public void LogEvent(string message, EventLogEntryType type)
        {
            systemEventLogger.WriteEntry(message, type);
        }

        /// <summary>
        /// Dispose of managed and native resources
        /// </summary>
        /// <param name="disposing"></param>
        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
                // dispose managed resources
                systemEventLogger.Close();
            }
            // free native resources
        }

        /// <summary>
        /// Dispose of managed and native resources
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}
