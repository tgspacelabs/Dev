using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spacelabs.WaveformSse.Logging
{
    /// <summary>
    ///     Usage: 
    ///         ISLNILogger logger = SNLILogger.CreateLogger(context); // where context is a string ie: "SLNI.Service"
    ///         
    ///         logger.Log(LogLevel.INFO, ("Something to always log");
    ///         
    ///         
    /// </summary>
    /// 

    public enum LogLevel
    {
        ALWAYS,
        EXCEPTION,
        ERROR,
        WARN,
        INFO,
        DEBUG,
        TRACE,
        SECURITY_SUCCESS,
        SECURITY_FAIL,
    }


    public interface ILogger
    {

        void Log(LogLevel level, string format, params object[] args);

        LogLevel Level { get; set; }
    }


}
