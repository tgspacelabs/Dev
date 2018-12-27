using System;
using System.Diagnostics;
using System.IO;
using System.Threading;

namespace Spacelabs.WaveformSse.Logging
{
    public class FileLogger
    {
        private static object thisLock = new object();
        private static readonly string LogFileName = $"{AppDomain.CurrentDomain.FriendlyName.Split('.')[0]}_Log" + DateTime.Now.ToString("-dd-MMM-yyyy-h_mm_ss_ff") + ".log";

        /// <summary>
        ///     This internal routine adds a prefix to the text to be logged.
        ///     The prefix includes:
        ///                         Long TimeStamp : [<Current ThreadId>:<Current Thread Priority>] <Name of calling Method>
        ///     
        /// </summary>
        /// <param name="framesToSkip">How many frames of call stack to skip to find Method to be logged</param>
        /// <param name="textToLog">Text to log</param>
        private static void LogIt(int framesToSkip, string textToLog)
        {
            lock (thisLock)
            {
                Thread t = Thread.CurrentThread;
                DateTime time = DateTime.Now;
                StackTrace st = new StackTrace(framesToSkip, true);
                StackFrame sf = st.GetFrame(0);
                string textWithPrefix = time.ToLongTimeString() + ": [" + t.ManagedThreadId.ToString() + ":" + t.Priority.ToString() + "] " + sf.GetMethod().Name + " " + textToLog + Environment.NewLine;
                //File.AppendAllText(LogFileName, textWithPrefix);
            }
        }

        /// <summary>
        ///     LogData is deprecated but here to provide compatablity with original SimpleLogger
        /// </summary>
        /// <param name="data"></param>
        public static void LogData(string data)
        {
            LogIt(2, data);
        }

        /// <summary>
        ///         Allows logging with a format specifier
        /// </summary>
        /// <param name="framesToSkip">How many frames of call stack to skip to find Method to be logged</param>
        /// <param name="format">Format specifier</param>
        /// <param name="args">Arguments to be formatted</param>
        public static void Log(int framesToSkip, string format, params object[] args)
        {
            try
            {
                string data = "";
                if (args != null)
                {
                    data = string.Format(format, args);
                }
                //data = JsonHelper.ReplaceIdsWithNames(data);
                LogIt(2 + framesToSkip, data);
            }
            catch (Exception e)
            {
                LogIt(2 + framesToSkip, "Bad format:");
                LogIt(2 + framesToSkip, format);
                LogIt(2 + framesToSkip, e.Message);
            }
        }

        /// <summary>
        ///         Allows logging without a format specifier.
        ///         This is needed when logging json response text.
        ///         
        /// </summary>
        /// <param name="framesToSkip">How many frames of call stack to skip to find Method to be logged</param>
        /// <param name="text">Text to be logged</param>
        public static void LogRaw(int framesToSkip, string text)
        {
            LogIt(2 + framesToSkip, text);
        }
    }
}
