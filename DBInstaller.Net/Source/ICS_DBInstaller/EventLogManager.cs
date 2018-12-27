using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;

namespace Spacelabs.DBInstaller
{
    public class EventLogManager
    {
        #region Declarations

        private static volatile EventLogManager eventLogManager;
        private static object syncObject = new Object();
        IEventLog eventLogger = null;

        #endregion Declarations

        /// <summary>
        /// C'tor
        /// </summary>
        private EventLogManager()
        {
        }
        /// <summary>
        /// Creates or returns the one and only one instance of the WaveformManager as IWaveformManager
        /// </summary>
        /// <returns>IWaveformManager</returns>
        public static EventLogManager Instance()
        {
            lock (syncObject)
            {
                if (eventLogManager == null)
                {
                    eventLogManager = new EventLogManager();
                }
            }
            return eventLogManager;
        }
        /// <summary>
        /// Sets the event logger reference
        /// </summary>
        public IEventLog Logger
        {
            set
            {
                if (value == null)
                    throw new ArgumentNullException("Logger");

                eventLogger = value;
            }
        }
        /// <summary>
        /// Writes the information entry to the event log
        /// </summary>
        /// <param name="message"></param>
        public void LogInformation(string message)
        {
            if (eventLogger == null)
                throw new ArgumentNullException("Logger");
            eventLogger.LogEvent(message, EventLogEntryType.Information);
        }
        /// <summary>
        /// Writes a warning entry to the event log
        /// </summary>
        /// <param name="message"></param>
        public void LogWarning(string message)
        {
            if (eventLogger == null)
                throw new ArgumentNullException("Logger");
            eventLogger.LogEvent(message, EventLogEntryType.Warning);
        }
        /// <summary>
        /// Writes an error entry to the event log
        /// </summary>
        /// <param name="message"></param>
        public void LogError(string message)
        {
            if (eventLogger == null)
                throw new ArgumentNullException("Logger");
            eventLogger.LogEvent(message, EventLogEntryType.Error);
        }
    }
}
