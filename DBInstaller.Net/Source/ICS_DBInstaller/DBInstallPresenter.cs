// ------------------------------------------------------------------------------------------------
// File: DBInstallPresenter.cs
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
using System.IO;
using System.Text.RegularExpressions;
using System.Data;
using System.Diagnostics;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Windows.Forms;
using System.Reflection;

namespace Spacelabs.DBInstaller
{
    public class DBInstallPresenter
    {
        #region Declarations

        IDBInstall view = null;
        IRegistry registryHelper = null;
        ISqlHelper sqlHelper = null;
        Encryptor encryptor = null;
        static Localization resource = null;
        const string PORTAL_DBNAME = "portal";
        const string DB_USERNAME = "portal";
        string installingVersion = string.Empty, installedVersion = string.Empty;

        public event EventHandler<ReportProgressEventArgs> ReportProgress;
        public event EventHandler<SelectSqlInstanceEventArgs> SelectInstance;

        #endregion Declarations

        /// <summary>
        /// Overloaded constructor of the presenter
        /// </summary>
        /// <param name="dbView">reference to view</param>
        /// <param name="regHelper">reference to registry helper</param>
        /// <param name="res">reference to resource manager</param>
        public DBInstallPresenter(IDBInstall dbView, IRegistry regHelper, Localization res)
        {
            this.view = dbView ;
            this.registryHelper = regHelper;
            resource = res;
            encryptor = new Encryptor();
        }

        #region Properties
        /// <summary>
        /// Gets or sets server name
        /// </summary>
        public string ServerName { get; set; }        
        /// <summary>
        /// Gets or sets selected SQL instance
        /// </summary>
        public string SelectedSqlInstance { get; set; }
        /// <summary>
        /// Gets or sets database name
        /// </summary>
        public string DatabaseName { get; set; }
        /// <summary>
        /// Gets or sets database password
        /// </summary>
        public string DBPassword { get; set; }
        /// <summary>
        /// Gets or sets database user name
        /// </summary>
        public string DBUserName { get; set; }
        /// <summary>
        /// Gets or sets database SAPassword
        /// </summary>
        public string SAPassword { get; set; }
        /// <summary>
        /// Gets or sets database restore path
        /// </summary>
        public string DBRestorePath { get; set; }
        /// <summary>
        /// Gets the installed portal database version
        /// </summary>
        public string InstalledVersion { get { return installedVersion; } }
        /// <summary>
        /// Gets the installing portal database version
        /// </summary>
        public string InstallingVersion { get { return installingVersion; } }

        #endregion Properties        
        /// <summary>
        /// Handler for the next button click
        /// </summary>
        /// <param name="helper"></param>
        /// <returns></returns>
        public bool OnNextButtonClick(ISqlHelper helper)
        {
            sqlHelper = helper;
              
            //validate user inputs
            if (!ValidateInputs())
            {
                return false;
            }
            if (!IsSupportedSqlVersion())
            {
                view.DisplayMessageBox(resource.Language.GetString("UnSupportedSqlVersion"), System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Warning);
                return false;
            }            
            return true;
        }      
        #region DBConfiguration
        /// <summary>
        /// Entry method for the configuration action.
        /// </summary>
        /// <returns></returns>
        public bool Configure()
        {
            bool bRet = true;
            //check db connection
            if (sqlHelper.SqlConn.State != ConnectionState.Open)
            {
                if (!sqlHelper.OpenConnection())
                {
                    return false;
                }
            }
            //check login and create if doesn't exist
            if (!DoesLoginExist(DBUserName))
            {
                //create
                if (!CreateLogin(DBUserName, DBPassword))
                {
                    return false;
                }
            }
            //check database and create if doesn't exist
            if (!DoesDatabaseExist(DatabaseName))
            {
                //create database
                if (!CreateDatabase(DatabaseName))
                {
                    return false;
                }

                //set recovery model
                if (!SetDBRecoveryMode(SqlRecoveryModel.Simple))
                {
                    return false;
                }
                // install schema & portal data
                if (!InstallDBSchema())
                {
                    return false;
                }
                if (!InstallPortalData())
                {
                    return false;
                }
                // set default database
                if (!SetDefaultDatabase(DatabaseName, DBUserName))
                {
                    return false;
                }
                // Set default language
                if (!SetDBDefaultLanguage(DatabaseName))
                {
                    return false;
                }
                //change starter set
                string langcode;
                langcode = CommonUtility.SystemLocale;
                if (!ChangeDBStarterSet(langcode))
                {
                    return false;
                }
                //update vitals & trends xml
                if (!UpdateVitals_TrendFormats())
                {
                    return false;
                }
                //install maintenance jobs
                if (!ConfigureMaintenanceJobs())
                {
                    return false;
                }

            }
            //set database owner
            if (!SetDBOwner(DatabaseName, DBUserName))
            {
                return false;
            }

            //successful configuration...
            ReportProgress(this, new ReportProgressEventArgs(resource.Language.GetString("ConfigSuccess")));
            return bRet;
        }
        /// <summary>
        /// Checks if the specified database exists in the SQL server
        /// </summary>
        /// <param name="dbname"></param>
        /// <returns></returns>
        bool DoesDatabaseExist(string dbname)
        {
            bool bExists = true;
            string query = "SELECT * FROM master.dbo.sysdatabases where name =" + CommonUtility.GetSingleQuotedString(dbname);
            DataSet dset = sqlHelper.ExecuteSqlCommandWithDataSet(query);
            if (dset != null && dset.Tables.Count > 0 && dset.Tables[0].Rows.Count > 0)
            {
                //database exists
                bExists = true;
                dset.Dispose();
            }
            else
            {
                //doesn't exist
                bExists = false;
            }
            return bExists;
        }
        /// <summary>
        /// Method to install the portal database schema
        /// </summary>
        /// <returns></returns>
        bool InstallDBSchema()
        {
            ReportProgress(this, new ReportProgressEventArgs(resource.Language.GetString("Progress_schema")));
            bool bInstalled = true;
            string schemaFilePath = GetDatabaseInstallPath() + @"Portal_schema.sql";
            bInstalled = sqlHelper.ExecuteSqlScript(schemaFilePath);
            return bInstalled;
        }
        /// <summary>
        /// Method to populate the portal database with initial data
        /// </summary>
        /// <returns></returns>
        bool InstallPortalData()
        {
            ReportProgress(this, new ReportProgressEventArgs(resource.Language.GetString("Progress_data")));
            bool bInstalled = true;
            string portalDataFilePath = GetDatabaseInstallPath() + @"Portal_data.sql";
            bInstalled = sqlHelper.ExecuteSqlScript(portalDataFilePath);
            return bInstalled;
        }
        /// <summary>
        /// Retrieves the database install path on the local machine
        /// </summary>
        /// <returns></returns>
        string GetDatabaseInstallPath()
        {
            string installPath = string.Empty;

            installPath = registryHelper.GetRegistryValue(CommonUtility.SLCoreSvcPath, CommonUtility.InstallKey);

            if (!string.IsNullOrEmpty(installPath))
            {
                installPath += @"Database\";
            }
            else
            {
                ////default path
                installPath = CommonUtility.DefaultScriptFilesPath;
            }
            return installPath;
        }
        /// <summary>
        /// Sets the specified user as the owner of the specified database
        /// </summary>
        /// <param name="dbname"></param>
        /// <param name="user"></param>
        /// <returns></returns>
        bool SetDBOwner(string dbname, string user)
        {
            bool bSet = true;
            string query = "USE " + dbname;
            bSet = sqlHelper.ExecuteSqlCommand(query);
            query = string.Empty;
            query = "EXEC sp_changedbowner " + CommonUtility.GetSingleQuotedString(user);
            bSet = sqlHelper.ExecuteSqlCommand(query);
            return bSet;
        }
        /// <summary>
        /// Sets the database recovery model for the newly created portal database
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        bool SetDBRecoveryMode(SqlRecoveryModel model)
        {
            bool bSet = true;
            string query = "ALTER DATABASE ["+ DatabaseName + "] SET RECOVERY "+ model.ToString();
            bSet = sqlHelper.ExecuteSqlCommand(query);
            return bSet;
        }
        /// <summary>
        /// Sets the specified database as the default for the specified user
        /// </summary>
        /// <param name="dbname"></param>
        /// <param name="user"></param>
        /// <returns></returns>
        bool SetDefaultDatabase(string dbname, string user)
        {
            bool bSet = true;
            string query = "EXEC sp_defaultdb @loginame = "+ CommonUtility.GetSingleQuotedString(user) +   ", @defdb = "+CommonUtility.GetSingleQuotedString(dbname);
            bSet = sqlHelper.ExecuteSqlCommand(query);
            return bSet;
        }
        /// <summary>
        /// configures the SQL maintenance jobs
        /// </summary>
        /// <returns></returns>
        bool ConfigureMaintenanceJobs()
        {
            ReportProgress(this, new ReportProgressEventArgs(resource.Language.GetString("Progress_maintjobs")));
            bool bInstalled = true;
            string jobscriptFilePath = GetDatabaseInstallPath() + @"JobTask.sql";
            bInstalled = sqlHelper.ExecuteSqlScript(jobscriptFilePath);
            return bInstalled;
        }
        /// <summary>
        /// method to update trends and vitals format xml
        /// </summary>
        /// <returns></returns>
        bool UpdateVitals_TrendFormats()
        {            
            string LangCode;
            string vitalsFilePath, trendsFilePath;
            bool bUpdated = true;
            LangCode = CommonUtility.SystemLocale;
            vitalsFilePath = GetDatabaseInstallPath() + LangCode + @"\" + CommonUtility.VitalsFileName;
            //UpdateVitalsXML('trend', 'vitals', 'True', FilePath);
             string query = "EXEC portal.dbo.UpdateXMLValue " + CommonUtility.GetSingleQuotedString("trend")+"," +CommonUtility.GetSingleQuotedString("vitals") +","
                 + CommonUtility.GetSingleQuotedString("true") + "," + CommonUtility.GetSingleQuotedString(vitalsFilePath);
             if (!sqlHelper.ExecuteSqlCommand(query))
                 return false;
             
            trendsFilePath = GetDatabaseInstallPath() + LangCode + @"\" + CommonUtility.TrendsFileName;
            query = string.Empty;
            query = "EXEC portal.dbo.UpdateXMLValue " + CommonUtility.GetSingleQuotedString("trend") + "," + CommonUtility.GetSingleQuotedString("layouts") + ","
                + CommonUtility.GetSingleQuotedString("false") + "," + CommonUtility.GetSingleQuotedString(trendsFilePath);
            bUpdated = sqlHelper.ExecuteSqlCommand(query);

            return bUpdated;
        }
        /// <summary>
        /// Sets the starter set (i.e. language to load) for the database
        /// </summary>
        /// <param name="langcode"></param>
        /// <returns></returns>
        bool ChangeDBStarterSet(string langcode)
        {
            bool bChanged = true;
            string query = "EXEC dbo.change_starter_set " + CommonUtility.GetSingleQuotedString(langcode);
            bChanged = sqlHelper.ExecuteSqlCommand(query);
            query = string.Empty;
            query = "EXEC dbo.p_set_lang" + CommonUtility.GetSingleQuotedString(langcode);
            bChanged = sqlHelper.ExecuteSqlCommand(query);
            return bChanged;
        }
        /// <summary>
        /// Sets the default language of the database
        /// </summary>
        /// <param name="dbname"></param>
        /// <returns></returns>
        bool SetDBDefaultLanguage(string dbname)
        {
            bool bSet = true;
            string query = "EXEC sp_defaultlanguage @loginame =" + CommonUtility.GetSingleQuotedString(dbname) + ", @language = " +CommonUtility.GetSingleQuotedString("English");
            bSet = sqlHelper.ExecuteSqlCommand(query);
            return bSet;
        }
        /// <summary>
        /// method that does post configuration stuff like writing connection information settings to registry.
        /// </summary>
        /// <returns></returns>
        public bool OnFinish()
        {
            bool bRet = true;
            string sysFilePath = GetDatabaseInstallPath() + "System.sql";
            bRet = sqlHelper.ExecuteSqlScript(sysFilePath);

            bRet &= registryHelper.SetRegistryValue(CommonUtility.SLCoreSvcPath, CommonUtility.ServerKey, sqlHelper.DataSource);
            bRet &= registryHelper.SetRegistryValue(CommonUtility.SLCoreSvcPath, CommonUtility.UserNameKey, DBUserName);
            bRet &= registryHelper.SetRegistryValue(CommonUtility.SLCoreSvcPath, CommonUtility.PasswordKey, encryptor.Encrypt(DBPassword, null));
            bRet &= registryHelper.SetRegistryValue(CommonUtility.SLCoreSvcPath, CommonUtility.DatabaseKey, DatabaseName);
            
            return bRet;
        }
        /// <summary>
        /// Checks if the installed SQL is of ICS supported version
        /// </summary>
        /// <returns></returns>
        bool IsSupportedSqlVersion()
        {
            bool bSupported = true;
            string query = "select @@Version";
            string version = string.Empty;
            DataSet dset = sqlHelper.ExecuteSqlCommandWithDataSet(query);
            if (dset != null && dset.Tables.Count > 0 && dset.Tables[0].Rows.Count > 0)
            {
                version = dset.Tables[0].Rows[0].ItemArray[0].ToString();

                // SQL Server 2012 or 2014
                if (version.Contains("11.") || version.Contains("12."))
                    bSupported = true;
                else
                    bSupported = false;
            }
            return bSupported;
        }
        /// <summary>
        /// Creates a sql database with the specified name
        /// </summary>
        /// <param name="dbname"></param>
        /// <returns></returns>
        bool CreateDatabase(string dbname)
        {
            bool bCreated = false;

            var strQuery = GetStringResource("Spacelabs.DBInstaller.DBCreationScriptTemplate.sql")
                .Replace("{DATABASE_NAME}", dbname)
                .Replace("{DB_INSTALLATION_PATH}", DBRestorePath);

            bCreated = sqlHelper.ExecuteSqlCommand(strQuery);

            return bCreated;
        }

        static string GetStringResource(string resourceName)
        {
            using (var streamReader = new StreamReader(
                Assembly.GetExecutingAssembly().GetManifestResourceStream(
                    resourceName)))
            {
                return streamReader.ReadToEnd();
            }
        }

        /// <summary>
        /// Creates the specified login
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        bool CreateLogin(string username, string password)
        {
            bool bCreated = false;
            string strQuery = @"USE [master]; CREATE LOGIN " + username + @" WITH PASSWORD=" + @"'" + password + @"' , DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;";
            bCreated = sqlHelper.ExecuteSqlCommand(strQuery);

            if(bCreated)
            {
                string sqlcmd = "EXEC [sys].[sp_addsrvrolemember] \'{0}\', \'bulkadmin\';";
                sqlcmd = String.Format(CultureInfo.CurrentCulture, sqlcmd, username);
                bCreated = sqlHelper.ExecuteSqlCommand(sqlcmd);
            }

            return bCreated;
        }
        /// <summary>
        /// Checks if the specified login exists
        /// </summary>
        /// <param name="login"></param>
        /// <returns></returns>
        bool DoesLoginExist(string login)
        {
            bool bExists = false;
            string query = "select * from sys.syslogins where loginname = " + CommonUtility.GetSingleQuotedString(login);
            DataSet dset = sqlHelper.ExecuteSqlCommandWithDataSet(query);
            if (dset != null && dset.Tables.Count > 0 && dset.Tables[0].Rows.Count > 0)
            {
                //login exists
                bExists = true;
                dset.Dispose();
            }
            else
            {
                //login doesn't exist
                bExists = false;
            }
            return bExists;
        }
       
        #endregion DBConfiguration
        
        /// <summary>
        /// Loads the server connection information from registry
        /// </summary>
        public void LoadSettingsFromRegistry()
        {
            ServerName = Environment.MachineName; //default to machine name for this version of ICS
            string DataSource = registryHelper.GetRegistryValue(CommonUtility.SLCoreSvcPath, CommonUtility.ServerKey);
            if (!string.IsNullOrEmpty(DataSource))
            {
                if (DataSource.Contains('\\'))
                {
                    //named instance
                    DataSource = DataSource.Split('\\')[1];
                }
                else
                {
                    //default instance
                    DataSource = "Default Instance";
                }

                if (SelectInstance != null)
                    SelectInstance(this, new SelectSqlInstanceEventArgs(DataSource));
            }

            DatabaseName = registryHelper.GetRegistryValue(CommonUtility.SLCoreSvcPath, CommonUtility.DatabaseKey);
            if (string.IsNullOrEmpty(DatabaseName))
                DatabaseName = PORTAL_DBNAME;
            DBUserName = registryHelper.GetRegistryValue(CommonUtility.SLCoreSvcPath, CommonUtility.UserNameKey);
            if (string.IsNullOrEmpty(DBUserName))
                DBUserName = DB_USERNAME;
            DBPassword = registryHelper.GetRegistryValue(CommonUtility.SLCoreSvcPath, CommonUtility.PasswordKey);
            if (!string.IsNullOrEmpty(DBPassword) && IsEncrypted(DBPassword))
            {
                DBPassword = encryptor.Decrypt(DBPassword, null);
            }
            view.UpdateUI();
        }
        /// <summary>
        /// determines if the given string is encrypted or plain text
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        bool IsEncrypted(string str)
        {
            try
            {
               encryptor.Decrypt(str, null);
               return true;
            }
            catch (ArgumentOutOfRangeException ex)
            {
                EventLogManager.Instance().LogError(ex.Message);
                return false;
            }
        }
        /// <summary>
        /// method to update database restore path when the selected SQL instance changed
        /// </summary>
        /// <param name="newInstanceName"></param>
        public void SelectedSqlInstanceChanged(string newInstanceName)
        {
            if (!string.IsNullOrEmpty(newInstanceName))
            {
                DBRestorePath = CommonUtility.SqlInstanceCollection[newInstanceName] + @"\DATA";
                view.UpdateSqlRestorePath(DBRestorePath);
            }
        }

        /// <summary>
        /// Validates the user inputs
        /// </summary>
        /// <returns></returns>
        bool ValidateInputs()
        {
            bool bRet = true;
                        
            //validate sa password            
            if (!sqlHelper.OpenConnection())
            {
                view.DisplayMessageBox(resource.Language.GetString("InvalidSAPassword"), MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            //validate db restore path
            if (!ValidatePath(DBRestorePath))
            {
               return false;
            }
            return bRet;
        }        
        /// <summary>
        /// checks if the specified path is accessible
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        bool CheckAccess(string path)
        {
            bool bRet = false;
            string fname = string.Empty;
            
            if (path[path.Length - 1] == '\\')
                fname = path + "test.txt";
            else
                fname = path + @"\test.txt";

            try
            {
                FileStream fst = File.Open(fname, FileMode.OpenOrCreate);
                fst.Close();

                File.Delete(fname);
                bRet = true;
            }
            catch (UnauthorizedAccessException accessex)
            {
                EventLogManager.Instance().LogError(accessex.Message);
                view.DisplayMessageBox(resource.Language.GetString("NoAccess"), System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Warning);
                bRet = false;
            }
            catch (ArgumentNullException ex)
            {
                view.DisplayMessageBox(ex.Message, System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Warning);
                bRet = false;
            }
            catch (InvalidOperationException ex)
            {
                view.DisplayMessageBox(ex.Message, System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Warning);
                bRet = false;
            }
            catch (System.Resources.MissingManifestResourceException ex)
            {
                view.DisplayMessageBox(ex.Message, System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Warning);
                bRet = false;
            }
            return bRet;
        }
        /// <summary>
        /// validates the specified database restore path
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        bool ValidatePath(string path)
        {
            bool bRet = true;
            string pattern = @"^(([a-zA-Z]\:)|(\\))(\\{1}|((\\{1})[^\\]([^/:*?<>""|]*))+)$";
            if(!Regex.IsMatch(path,pattern))
            {
                view.DisplayMessageBox(resource.Language.GetString("InvalidDBRestorePath"), System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Warning);
                return false;
            }

            if (Directory.Exists(path))
            {
                //check permissions now
                if (CheckAccess(path))
                {
                    bRet = true;
                }
                else
                {
                    bRet = false;
                }
            }
            else
            {
                try
                {
                    Directory.CreateDirectory(path);
                }
                catch (ArgumentNullException ex)
                {
                    view.DisplayMessageBox(ex.Message + "\r\n" + resource.Language.GetString("SpecifyValidPath"), System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Warning);
                    bRet = false;
                }               
                catch (UnauthorizedAccessException ex)
                {
                    view.DisplayMessageBox(ex.Message + "\r\n" + resource.Language.GetString("SpecifyValidPath"), System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Warning);
                    bRet = false;
                }
                catch (System.IO.PathTooLongException ex)
                {
                    view.DisplayMessageBox(ex.Message + "\r\n" + resource.Language.GetString("SpecifyValidPath"), System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Warning);
                    bRet = false;
                }
                catch (System.IO.IOException ex)
                {
                    view.DisplayMessageBox(ex.Message + "\r\n" + resource.Language.GetString("SpecifyValidPath"), System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Warning);
                    bRet = false;
                }
                catch (NotSupportedException ex)
                {
                    view.DisplayMessageBox(ex.Message + "\r\n" + resource.Language.GetString("SpecifyValidPath"), System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Warning);
                    bRet = false;
                }
                catch (ArgumentException ex)
                {
                    view.DisplayMessageBox(ex.Message + "\r\n" + resource.Language.GetString("SpecifyValidPath"), System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Warning);
                    bRet = false;
                }
            }

            return bRet;
        }

        /// <summary>
        /// detects if portal database already exists and requires an upgrade
        /// </summary>
        /// <param name="installedVersion"></param>
        /// <returns></returns>
        public InstallType DetectUpgrade()
        {
            InstallType installType = InstallType.None;

            installedVersion = string.Empty;
            installingVersion = string.Empty;

            if (DoesDatabaseExist(DatabaseName))
            {
                installedVersion = GetInstalledVersion();
                installingVersion = GetInstallingVersion(GetDatabaseInstallPath() + @"Portal_data.sql");
                if (installedVersion.ToUpperInvariant().Equals(installingVersion.ToUpperInvariant()))
                {
                    installType = InstallType.None;
                }
                //MessageBox.Show("Installed version: " + installedVersion + "      Installing version: " + installingVersion);
                if (installingVersion.StartsWith("4.03.", StringComparison.OrdinalIgnoreCase)
                    && (installedVersion.StartsWith("4.02.01", StringComparison.OrdinalIgnoreCase) || installedVersion.StartsWith("4.02.02", StringComparison.OrdinalIgnoreCase)))
                {
                    //upgrade allowed only from 4.02.01 / 4.02.02 to 4.03.
                    installType = InstallType.Upgrade;
                }
            }
            else
            {
                installType = InstallType.Configure;
            }
            return installType;
        }
        /// <summary>
        /// retrieves the version information from portal data script
        /// </summary>
        /// <returns></returns>
        string GetInstallingVersion(string schemaFilePath)
        {
            string version = null;
            try
            {
                string text = File.ReadAllText(schemaFilePath);
                int index = text.IndexOf("ver_code", StringComparison.OrdinalIgnoreCase);
                int index2 = text.IndexOf("'", index, StringComparison.OrdinalIgnoreCase);
                index2 += 1;
                int index3 = text.IndexOf("'", index2, StringComparison.OrdinalIgnoreCase);
                version = text.Substring(index2, index3 - index2);
            }
            catch (ArgumentNullException ex)
            {
                view.DisplayMessageBox(ex.Message, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            catch (ArgumentException ex)
            {
                view.DisplayMessageBox(ex.Message, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            catch (PathTooLongException ex)
            {
                view.DisplayMessageBox(ex.Message, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            catch (DirectoryNotFoundException ex)
            {
                view.DisplayMessageBox(ex.Message, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            catch (UnauthorizedAccessException ex)
            {
                view.DisplayMessageBox(ex.Message, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            catch (FileNotFoundException ex)
            {
                view.DisplayMessageBox(ex.Message, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            catch (IOException ex)
            {
                view.DisplayMessageBox(ex.Message, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            return version;
        }
        /// <summary>
        /// retrieves the installed ICS version from the existing portal database
        /// </summary>
        /// <returns></returns>
        string GetInstalledVersion()
        {
            string strVersion = string.Empty;

            DataSet ds = sqlHelper.ExecuteSqlCommandWithDataSet("use portal; select ver_code from dbo.int_db_ver order by install_dt desc");

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                strVersion = ds.Tables[0].Rows[0].ItemArray[0].ToString();
            }

            return strVersion;
        }
        /// <summary>
        /// executes the upgrade actions
        /// </summary>
        /// <returns></returns>
        public bool Upgrade()
        {
            bool bRet = true;
            string upgradeVersion = GetInstallingVersion(GetDatabaseInstallPath() + @"Portal_data.sql");

            //strip off the revision and build parts in the version string
            int offset = upgradeVersion.IndexOf('.');
            offset = upgradeVersion.IndexOf('.', offset + 1);
            upgradeVersion = upgradeVersion.Substring(0, offset);

            if (!UpgradeDBSchema(upgradeVersion))
            {
                return false;
            }
            if (!UpgradePortalData(upgradeVersion))
            {
                return false;
            }

            //successful upgrade...
            ReportProgress(this, new ReportProgressEventArgs(string.Format(CultureInfo.CurrentCulture, resource.Language.GetString("UpgradeSuccessful"), upgradeVersion)));

            return bRet;
        }
        /// <summary>
        /// upgrades the portal schema to the specified version
        /// </summary>
        /// <param name="upgradeVersion"></param>
        /// <returns></returns>
        bool UpgradeDBSchema(string upgradeVersion)
        {
            ReportProgress(this, new ReportProgressEventArgs(resource.Language.GetString("Progress_schema")));
            bool upgraded = true;
            string schemaDirPath = GetDatabaseInstallPath() + upgradeVersion + @"\schema";
            if (Directory.Exists(schemaDirPath))
            {
                foreach (string fileName in Directory.GetFiles(schemaDirPath))
                {
                    if (!string.IsNullOrEmpty(fileName))
                    {
                        if (Path.GetExtension(fileName).ToUpperInvariant().Equals(".SQL"))
                        {
                            upgraded = sqlHelper.ExecuteSqlScript(fileName);
                        }
                    }
                }
            }
            return upgraded;
        }
        /// <summary>
        /// upgrades the portal schema to the specified version
        /// </summary>
        /// <param name="upgradeVersion"></param>
        /// <returns></returns>
        bool UpgradePortalData(string upgradeVersion)
        {
            string dataDirPath = GetDatabaseInstallPath() + upgradeVersion + @"\data";
            ReportProgress(this, new ReportProgressEventArgs(resource.Language.GetString("Progress_data")));
            bool upgraded = true;
            if (Directory.Exists(dataDirPath))
            {
                foreach (string fileName in Directory.GetFiles(dataDirPath))
                {
                    if (!string.IsNullOrEmpty(fileName))
                    {
                        if (Path.GetExtension(fileName).ToUpperInvariant().Equals(".SQL"))
                        {
                            upgraded = sqlHelper.ExecuteSqlScript(fileName);
                        }
                    }
                }
            }
            return upgraded;
        }
    }
}

