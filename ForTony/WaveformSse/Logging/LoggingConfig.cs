using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;

namespace Spacelabs.WaveformSse.Logging
{
    public class LoggingConfig : ILoggingConfig
    {
        /// <summary>
        /// CheckPoint is solely used for debugging startup issues
        /// To enable change _DebugStartup to true
        /// </summary>
        /// <param name="what"></param>
        /// <param name="detail"></param>
        private static void CheckPoint(string what, string detail = "None")
        {
            if (_DebugStartup)
            {
                what = what.Replace(".", "_");
                DateTime dt = DateTime.Now;
                int pid = Process.GetCurrentProcess().Id;
                string fname = string.Format("Checkpoint {0:D2} {1:D2} {2:D2} {3:D3} {4} {5}.txt", dt.Hour, dt.Minute, dt.Second, dt.Millisecond, what, pid);
                string path = @"C:\ProgramData\Spacelabs\SLNI\Logs";
                string fullPath = Path.Combine(path, fname);
                File.WriteAllText(fullPath, detail);
            }
        }

        #region Constant Definitions
        const string loggingBase = "Logging.";
        #endregion Constant Definitions

        #region Private Type/Class Definitions

        private class LoggingConfigItem : ILoggingConfigItem
        {
            private object thisLock = new object();

            private string _Context;

            public string Context
            {
                get
                {
                    lock (thisLock)
                    {
                        return _Context;
                    }
                }
                private set
                {
                    lock (thisLock)
                    {
                        _Context = value;
                    }
                }
            }

            private LogLevel _Level;
            public LogLevel Level
            {
                get
                {
                    lock (thisLock)
                    {
                        return _Level;
                    }
                }
                private set
                {
                    lock (thisLock)
                    {
                        _Level = value;
                    }
                }
            }
            private List<LogMethod> _Methods;

            public List<LogMethod> Methods
            {
                get
                {
                    lock (thisLock)
                    {
                        return _Methods;
                    }
                }
                private set
                {
                    lock (thisLock)
                    {
                        _Methods = value;
                    }
                }
            }

            /// <summary>
            /// ctor for LoggingConfigItem
            /// </summary>
            /// <param name="context"></param>
            /// <param name="level"></param>
            /// <param name="methods">Comma delimited string of logging level followed by logging method names</param>
            public LoggingConfigItem(string context, string levelAndMethods)
            {
                Context = context;
                string[] tokens = levelAndMethods.Split(',');
                Level = LogLevel.DEBUG;
                LogLevel tempLevel = LogLevel.INFO;
                Methods = new List<LogMethod>();
                if (tokens.Count() >= 2)
                {
                    if (Enum.TryParse(tokens[0], true, out tempLevel))
                    {
                        Level = tempLevel;
                    }

                    for (int i = 1; i < tokens.Count(); i++)
                    {
                        LogMethod method;
                        if (Enum.TryParse(tokens[i], true, out method))
                        {
                            Methods.Add(method);
                        }
                    }
                }
            }
        }

        #endregion Private Type/Class Definitions

        #region Private Field Definitions
        static ILoggingConfig instance = null;
        static readonly object mylock = new object();
        static Dictionary<string, ILoggingConfigItem> _configDict = new Dictionary<string, ILoggingConfigItem>();
        private static bool _DebugStartup = true; // Leaving set true for a while to discover uninitialized loggers
        #endregion Private Field Definitions

        #region Constructors
        private LoggingConfig()
        {
            //_configDict.Add("SLNI", new LoggingConfigItem("SLNI", "DEBUG,USL"));
            //_configDict.Add("SLNI.Service.API", new LoggingConfigItem("SLNI.Service.API", "DEBUG,GuidReplaceUSL"));
            //_configDict.Add("SLNI.Service.API.Exceptions", new LoggingConfigItem("SLNI.Service.API.Exceptions", "DEBUG,GuidReplaceUSL,EventLog"));
            foreach (string key in ConfigurationManager.AppSettings.Keys)
            {
                if (key.StartsWith("Logging."))
                {
                    string value = ConfigurationManager.AppSettings[key];
                    string newkey = key.Replace("Logging.", "");
                    ILoggingConfigItem cfgItem = new LoggingConfigItem(newkey, value);
                    _configDict[newkey] = cfgItem;
                }
            }
        }

        static public ILoggingConfig Instance
        {
            get
            {
                lock (mylock)
                {
                    if (instance == null)
                    {
                        instance = new LoggingConfig();
                    }
                    return instance;
                }
            }
        }
        #endregion Constructors

        #region ILoggingConfig Implementation

        public ILoggingConfigItem GetConfigItem(string context)
        {
            ILoggingConfigItem retVal = null;
            string work = context;
            bool mustOutput = true;
            string configString = string.Empty;

            while (work != string.Empty)
            {
                //configString = ConfigurationManager.AppSettings[loggingBase + work];
                //if (configString != null && configString != string.Empty)
                //{
                //    mustOutput = (context != work);
                //    break;
                //}
                if (_configDict.TryGetValue(work, out retVal))
                {
                    mustOutput = (context != work);
                    break;
                }
                work = removeLast(work);
            }
            //if (configString == string.Empty || configString == null)
            if (retVal == null)
            {
                SetConfigItem(context, "DEBUG", "GuidReplaceUSL");
                retVal = new LoggingConfigItem(context, configString);
            }
            if (mustOutput)
            {
                //ConfigurationManager.AppSettings.Add(loggingBase + context, configString);
                _configDict[context] = retVal;
            }
            return retVal as ILoggingConfigItem;
        }

        public void SetConfigItem(string context, string level, string methods)
        {
            CheckPoint(string.Format("New Log Context {0}", context), level + "," + methods);
            _configDict.Add(context, new LoggingConfigItem(context, level + "," + methods));

        }

        #endregion ILoggingConfig Implementation

        #region Private Methods

        private string removeLast(string input)
        {
            string retval = string.Empty;
            int idx = input.LastIndexOf(".");
            if (idx > 0)
            {
                retval = input.Substring(0, idx);
            }

            return retval;
        }

        #endregion Private Methods
    }
}

