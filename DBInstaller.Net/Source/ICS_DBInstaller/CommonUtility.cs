// ------------------------------------------------------------------------------------------------
// File: CommonUtility.cs
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
using Microsoft.Win32;
using System.Net;
using System.Globalization;
using System.Runtime.InteropServices;
using Microsoft.SqlServer.Management.Smo;
using System.Data;
using System.IO;
using System.Diagnostics;
using System.Collections.ObjectModel;
using System.Management;
//using Microsoft.SqlServer.Management.Smo.Wmi;

namespace Spacelabs.DBInstaller
{
    public enum InstallType
    {
        None,
        Configure,
        Upgrade
    };
    public enum SqlVersion
    {
        None,
        SqlServer2012 = 110,
        SqlServer2014 = 120
    };
    public enum SqlRecoveryModel
    {
        Simple,
        Full,
        BulkLogged
    };

    public enum Platform
    {
        X86,
        X64
    };
    public static class CommonUtility
    {
        #region Declarations

        public const string SLCoreSvcPath = @"SOFTWARE\Spacelabs\CoreSvc";
        public const string ServerKey = "DBServer";
        public const string DatabaseKey = "DBName";
        public const string UserNameKey = "DBUser";
        public const string PasswordKey = "DBPassword";
        public const string InstallKey = "InstallDir";
        public const string DefaultScriptFilesPath = @"C:\Program Files\Spacelabs\ICS\Database\";
        public const string VitalsFileName = "Vitals_all.xml";
        public const string TrendsFileName = "Trends.xml";
        public const string DefaultSqlInstance = "Default Instance";
        
        const string SQL2012SCOPE = @"root\Microsoft\SqlServer\ComputerManagement11";
        const string SQL2014SCOPE = @"root\Microsoft\SqlServer\ComputerManagement12";
        const string WQLQUERY = @"select *from SqlServiceAdvancedProperty where SQLServiceType = 1 and ServiceName <> ""MSSQL$SQLEXPRESS"" and (PropertyName = ""INSTANCEID"" or PropertyName=""DATAPATH"" or PropertyName=""SKUNAME"" or PropertyName=""VERSION"" or PropertyName=""ISWOW64"" or PropertyName=""SPLEVEL"")";

        public static Dictionary<string, string> SqlInstanceCollection = new Dictionary<string, string>();

        #endregion Declarations

        #region Properties

        private static void AddSqlInstancesToCollection(Collection<string>instanceCollection, string scope, string queryString)
        {
            using (var sqlInstancesSearcher = new ManagementObjectSearcher(scope, queryString))
            {
                var sqlEngines = sqlInstancesSearcher.Get();

                try
                {
                    // If nothing is returned, SQL isn't installed.
                    if (sqlEngines.Count > 0)
                    {
                        foreach (ManagementBaseObject sqlEngine in sqlEngines)
                        {
                            foreach (PropertyData data in sqlEngine.Properties)
                            {
                                if (data.Value != null && data.Value.ToString().ToUpperInvariant().Equals("DATAPATH"))
                                {
                                    var serviceName = sqlEngine["ServiceName"].ToString();
                                    if (IsRunning(serviceName))
                                    {
                                        string instanceName;
                                        if (string.Equals(serviceName.ToUpperInvariant(), "MSSQLSERVER"))
                                        {
                                            instanceName = DefaultSqlInstance;
                                        }
                                        else
                                        {
                                            instanceName = serviceName.Split('$')[1];
                                        }

                                        if (!instanceCollection.Contains(instanceName))
                                        {
                                            instanceCollection.Add(instanceName);
                                            SqlInstanceCollection.Add(instanceName, sqlEngine.Properties["PropertyStrValue"].Value.ToString());
                                        }

                                    }
                                }
                            }
                        }

                    }
                }
                catch(Exception ex)
                {
                    EventLogManager.Instance().LogWarning(ex.ToString());
                    return;
                }
            }
        }

        public static Collection<string> InstalledSqlInstances
        {
            get
            {
                var instanceCollection = new Collection<string>();
                SqlInstanceCollection.Clear();

                try
                {
                    // Run a WQL query to return information about INSTANCEID, VERSION, DATAPATH, SKUNAME and SPLEVEL about installed instances except SQL Express
                    // of the SQL Engine.                
                    if (DoesScopeExist(SQL2014SCOPE))
                    {
                        AddSqlInstancesToCollection(instanceCollection, SQL2014SCOPE, WQLQUERY);
                    }
                    if (DoesScopeExist(SQL2012SCOPE))
                    {
                        AddSqlInstancesToCollection(instanceCollection, SQL2012SCOPE, WQLQUERY);
                    }

                    return instanceCollection;
                }
                catch (ManagementException)
                {
                    return null;
                }
            }
        }

        #endregion Properties


        #region helper methods

        /// <summary>
        /// Retrieves the detailed error information from the exception object
        /// and returns the error info as string
        /// </summary>
        /// <param name="ex"></param>
        /// <returns></returns>
        public static string GetMessageFromException(Exception ex)
        {
            string strExcpMsg = "";
            Exception eTemp = ex;

            while (eTemp != null)
            {
                strExcpMsg += eTemp.Message + "\n";
                eTemp = eTemp.InnerException;
            }
            return strExcpMsg;
        }        
        /// <summary>
        /// Single quotes the passed in string
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static string GetSingleQuotedString(string value)
        {
            string Temp;
            Temp = "'" +value +"'";
            return Temp;
        }
        /// <summary>
        /// Gets the system locale
        /// </summary>
        public static string SystemLocale
        {
            get
            {
                string threeLetterLocaleName = "ENU";

                CultureInfo cInfo = CultureInfo.CurrentCulture;
                switch (cInfo.TwoLetterISOLanguageName)
                {
                    case "zh":
                        //dbLanguage = "Chinese Simplified";
                        threeLetterLocaleName = "CHS";
                        break;
                    case "cs":
                        //dbLanguage = "Czech";
                        threeLetterLocaleName = "CZE";
                        break;
                    case "nl":
                        //dbLanguage = "Dutch";
                        threeLetterLocaleName = "NLD";
                        break;
                    case "fr":
                        //dbLanguage = "French";
                        threeLetterLocaleName = "FRA";
                        break;
                    case "de":
                        //dbLanguage = "German";
                        threeLetterLocaleName = "DEU";
                        break;
                    case "it":
                        //dbLanguage = "Italian";
                        threeLetterLocaleName = "ITA";
                        break;
                    case "pl":
                        //dbLanguage = "Polish";
                        threeLetterLocaleName = "POL";
                        break;
                    case "pt":
                        //dbLanguage = "Portuguese";
                        threeLetterLocaleName = "PTB";
                        break;
                    case "es":
                        //dbLanguage = "Spanish";
                        threeLetterLocaleName = "ESP";
                        break;
                    case "sv":
                        //dbLanguage = "Swedish";
                        threeLetterLocaleName = "SWE";
                        break;
                    default:
                        //dbLanguage = "English";
                        threeLetterLocaleName = "ENU";
                        break;
                }

                return threeLetterLocaleName;
            }
            
        }       
        /// <summary>
        /// determines if the specified service is running or not
        /// </summary>
        /// <param name="serviceName"></param>
        /// <returns></returns>
        static bool IsRunning(string serviceName)
        {
            bool bRunning = false;
            try
            {
                string scope = @"\root\cimv2";
                using (ManagementObjectSearcher searcher = new ManagementObjectSearcher(scope, "SELECT * FROM Win32_Service WHERE Started = TRUE AND Name='" + serviceName + "'"))
                {
                    if (searcher != null && searcher.Get().Count > 0)
                    {
                        //SQL Server service - RUNNING 
                        bRunning = true;
                    }
                }
            }
            catch (ManagementException e)
            {
                // SQL Server service - UNVERIFIABLE 
                Console.WriteLine(e.Message);
            }

            return bRunning;
        }
        /// <summary>
        /// Checks if the given scope exists using windows management (WMI)
        /// </summary>
        /// <param name="scope"></param>
        /// <returns></returns>
        static bool DoesScopeExist(string scope)
        {
            bool bExists = true;

            ManagementScope mgmtScope = new ManagementScope(scope);
            try
            {
                mgmtScope.Connect();
                bExists = true;
            }
            catch (ManagementException)
            {
                //scope doesn't exist.
                bExists = false;
            }

            return bExists;
        }
        /// <summary>
        /// Checks if the sql server either 2012 or 2014 is installed locally
        /// </summary>
        /// <returns></returns>
        public static bool IsSqlInstalledLocally()
        {
            return DoesScopeExist(SQL2012SCOPE) || DoesScopeExist(SQL2014SCOPE);
        }
        /// <summary>
        /// returns the actual sql instance name from the display name
        /// </summary>
        /// <param name="displayName"></param>
        /// <returns></returns>
        public static string GetActualSqlInstanceName(string displayName)
        {
            string actualInstanceName = string.Empty;


            if (string.IsNullOrEmpty(displayName))
                return string.Empty;

            if (displayName.ToUpperInvariant().Equals(DefaultSqlInstance.ToUpperInvariant()))
            {
                actualInstanceName = "MSSQLSERVER";
            }
            else
            {
                actualInstanceName = displayName;
            }

            return actualInstanceName;
        }
        /// <summary>
        /// retrieves the data source name from the given SQL instance name
        /// </summary>
        /// <param name="instanceName"></param>
        /// <returns></returns>
        public static string GetDataSourceNameFromInstanceName(string instanceName)
        {
            string dataSourceName = string.Empty;

            if (string.IsNullOrEmpty(instanceName))
                return string.Empty;

            if (instanceName.ToUpperInvariant().Equals("MSSQLSERVER"))
                dataSourceName = Environment.MachineName;
            else
            {
                //named instance (should be of the form machine name\instance name
                dataSourceName = string.Format(CultureInfo.InvariantCulture, "{0}\\{1}",Environment.MachineName, instanceName);
            }

            return dataSourceName;
        }
        #endregion helper methods
    }
}

