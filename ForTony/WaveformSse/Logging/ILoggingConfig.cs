using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spacelabs.WaveformSse.Logging
{
    public enum LogMethod
    {
        USL,
        GuidReplaceUSL,
        EventLog
    }
    public interface ILoggingConfigItem
    {
        /// <summary>
        /// Context is one or more strings seperated by "." in the format (parent).(child).(childOfChild)....
        /// </summary>
        string Context { get; }
        LogLevel Level { get; }
        List<LogMethod> Methods { get; }
    }

    public interface ILoggingConfig
    {
        ILoggingConfigItem GetConfigItem(string context);
        void SetConfigItem(string context, string level, string methods);
    }
}
