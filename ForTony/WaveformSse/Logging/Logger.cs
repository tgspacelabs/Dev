using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text.RegularExpressions;
using System.Threading;

namespace Spacelabs.WaveformSse.Logging
{
    internal class Logger : ILogger
    {
        #region Constants

        const int BaseFramesToSkip = 5;

        #endregion Constants

        #region Local Type/Class definitions

        private delegate void LogToSomewhere(Logger logger, int numFramesToSkip, LogLevel level, string format, params object[] args);

        #endregion Local Type/Class definitions

        #region Private Field Definitions

        private string _context;
        private List<LogToSomewhere> _methods = new List<LogToSomewhere>();

        #endregion Private Field Definitions

        #region Constructors

        private Logger(string context)
        {
            _context = context;
            LoadConfig(context);
        }

        static public ILogger CreateLogger(string context)
        {
            var logger = new Logger(context);

            return logger;
        }

        #endregion Constructors


        #region ILogger I/F Implementation

        public LogLevel Level { get; set; }

        public void Log(LogLevel level, string format, params object[] args)
        {
            switch (level)
            {
                case LogLevel.SECURITY_SUCCESS:
                case LogLevel.SECURITY_FAIL:
                    /* Log SECURITY events to both file and "Windows Event Log"
                     * unconditionaly
                     */
                    GuidReplaceUSLLog(this, 0, level, format, args);
                    AppEventLog(this, 0, level, format, args);
                    break;
                default:
                    RouteLogging(level, _context, BaseFramesToSkip, format, args);
                    break;
            }
        }

        #endregion ILogger I/F Implementation

        #region Private Methods

        private void LoadConfig(string context)
        {
            ILoggingConfigItem cfg = LoggingConfig.Instance.GetConfigItem(context);
            Level = cfg.Level;
            _methods.Clear();
            foreach (LogMethod method in cfg.Methods)
            {
                switch (method)
                {
                    case LogMethod.USL:
                        {
                            _methods.Add(USLLog);
                            break;
                        }
                    case LogMethod.GuidReplaceUSL:
                        {
                            _methods.Add(GuidReplaceUSLLog);
                            break;
                        }
                    case LogMethod.EventLog:
                        {
                            _methods.Add(AppEventLog);
                            break;
                        }
                    default:
                        break;
                }
            }
        }

        internal void LoadEventConfig()
        {
            Level = LogLevel.ALWAYS;
            _methods.Clear();
            _methods.Add(AppEventLog);
        }

        private void RouteLogging(LogLevel level, string context, int numFramesToSkip, string format, params object[] args)
        {
            if (level <= Level)
            {
                foreach (LogToSomewhere logger in _methods)
                {
                    logger(this, numFramesToSkip, level, format, args);
                }
            }
        }

        private void USLLog(Logger logger, int numFramesToSkip, LogLevel level, string format, params object[] args)
        {
            string newFormat = level.ToString() + ": " + format;
            string textToLog = string.Format(newFormat, args);
            logger.LogIt(numFramesToSkip, textToLog);
        }

        private void GuidReplaceUSLLog(Logger logger, int numFramesToSkip, LogLevel level, string format, params object[] args)
        {
            string newFormat = level.ToString() + ": " + format;
            try
            {
                string textToLog = string.Format(newFormat, args);
                bool hasChanges = false;
                string friendlyText = GuidNameRepository.ReplaceIdsWithNames(textToLog, out hasChanges);
                logger.LogIt(numFramesToSkip, friendlyText);
            }
            catch (Exception ex)
            {
                logger.LogIt(numFramesToSkip, "Bad format: " + format + " or bad new format: " + newFormat + ". Exception message:" + ex.Message);
            }
        }

        private static long _counter = 0;
        private void AppEventLog(Logger logger, int numFramesToSkip, LogLevel level, string format, params object[] args)
        {
            string textToLog = string.Format(format, args);
            bool hasChanges = false;
            string friendlyText = GuidNameRepository.ReplaceIdsWithNames(textToLog, out hasChanges);

            EventLogEntryType typ = EventLogEntryType.Error;

            switch (level)
            {
                case LogLevel.ALWAYS:
                case LogLevel.DEBUG:
                case LogLevel.INFO:
                case LogLevel.TRACE:
                    typ = EventLogEntryType.Information;
                    break;
                case LogLevel.WARN:
                    typ = EventLogEntryType.Warning;
                    break;
                case LogLevel.SECURITY_SUCCESS:
                    friendlyText = level.ToString() + ": " + friendlyText;
                    typ = EventLogEntryType.Information;
                    break;
                case LogLevel.SECURITY_FAIL:
                    friendlyText = level.ToString() + ": " + friendlyText;
                    typ = EventLogEntryType.Error;
                    break;
                case LogLevel.ERROR:
                case LogLevel.EXCEPTION:
                default:
                    typ = EventLogEntryType.Error;
                    break;
            }
            try
            {
                EventLogger.LogData(friendlyText,
                    EventLogger.EventCategory.Unexpected,
                    EventLogger.EventId.General,
                    typ);
            }
            catch (Exception ex)
            {
                // If we can't get to event log 
                // we don't want service to shutdown
                var dt = DateTime.Now;
                var fname =
                    $"EventLogNotWritable {dt.Hour:D2} {dt.Minute:D2} {dt.Second:D2} {dt.Millisecond:D3} {_counter++}.txt";
                var path = @"C:\ProgramData\Spacelabs\SLNI\Logs";
                var fullPath = Path.Combine(path, fname);
                var textToWrite = $"{ex.ToString()}\r\n{friendlyText}";
                File.WriteAllText(fullPath, friendlyText);
            }

        }


        /// <summary>
        ///     This internal routine adds a prefix to the text to be logged and uses USL Logger to actually log 
        ///     The prefix includes:
        ///                [<Current ThreadId>:<Current Thread Priority>] <Name of calling Method>
        ///     
        /// </summary>
        /// <param name="framesToSkip">How many frames of call stack to skip to find Method to be logged</param>
        /// <param name="textToLog">Text to log</param>
        private void LogIt(int framesToSkip, string textToLog)
        {
            try
            {
                Thread t = Thread.CurrentThread;
                string textWithPrefix = " [" + t.ManagedThreadId.ToString() + "] " + " " + textToLog + Environment.NewLine;
                FileLogger.Log(framesToSkip, $"{_context} {textToLog}", null);

            }
            catch (Exception ex)
            {
                EventLogger.LogData("Primary logging to application log failed: " + ex,
                    EventLogger.EventCategory.SLNI,
                    EventLogger.EventId.General,
                    EventLogEntryType.Error);
            }
        }

        #endregion Private Methods


    }
}
