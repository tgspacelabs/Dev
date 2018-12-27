// ------------------------------------------------------------------------------------------------
// File: SQLHelper.cs
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
using System.Data.SqlClient;
using System.Data;
using System.Diagnostics;
using System.IO;
using Microsoft.SqlServer.Management.Smo;
using Microsoft.SqlServer.Management.Common;

namespace Spacelabs.DBInstaller
{
    class SQLHelper: ISqlHelper, IDisposable
    {
        #region declarations
        private SqlConnection sqlConn;
        private ServerConnection servConn;
        private Server server;
        public SqlConnection SqlConn
        {
            get { return sqlConn; }
        }
        string datasource;
        string msapassword;
        const string SA = "sa";
        #endregion declarations

        #region Properties
        public string DataSource
        {
            get { return datasource; }
        }

        public string Sapassword
        {
            get { return msapassword; }
        }
       
        #endregion Properties

        /// <summary>
        /// One and only parameterized constructor.
        /// </summary>
        /// <param name="servername">server name where the database is hosted</param>
        /// <param name="sapassword">SA password to the database</param>
        public  SQLHelper( string servername, string sapassword)
        {
            datasource = servername;
            msapassword = sapassword;
            sqlConn = new SqlConnection(ConnectionString);
            servConn = new ServerConnection(sqlConn);
            server = new Server(servConn);
        }       

        /// <summary>
        /// opens database connections
        /// </summary>
        /// <returns></returns>
         public bool OpenConnection()
         {
             bool bRet = true;

             if (sqlConn == null)
                 sqlConn = new SqlConnection(ConnectionString);
             if (sqlConn.State == ConnectionState.Open)
                 FreeConnection();
             try
             {
                 sqlConn.Open();
             }
             catch (SqlException ex)
             {
                 EventLogManager.Instance().LogError(ex.Message);
                 bRet = false;
             }
             return bRet;
         }

        /// <summary>
        /// Free the database connection.
        /// </summary>
         public bool FreeConnection()
         {
             if (sqlConn != null && sqlConn.State != ConnectionState.Closed)
             {
                 try
                 {
                     sqlConn.Close();
                     server.ConnectionContext.Disconnect();
                     return true;
                 }
                 catch (SqlException sqlex)
                 {
                     EventLogManager.Instance().LogError(sqlex.Message);
                     return false;
                 }
             }
             return true;
         }
        /// <summary>
        /// Gets the connection STR.
        /// </summary>
        /// <returns></returns>
         public string ConnectionString
         {
             get
             {
                 SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
                 builder.DataSource = DataSource;
                 builder.InitialCatalog = "master";
                 builder.UserID = SA;
                 builder.Password = Sapassword;
                 builder.ConnectTimeout = 120;

                 return builder.ConnectionString;
             }
         }
        /// <summary>
        /// Executes the given sql command and result is returned as DataSet
        /// </summary>
        /// <param name="strCommand"></param>
        /// <returns></returns>
         public DataSet ExecuteSqlCommandWithDataSet(string strCommand)
         {
             DataSet resultDataSet = null;            
                 try
                 {                     
                     resultDataSet = server.ConnectionContext.ExecuteWithResults(strCommand);
                 }
                 catch (InternalSmoErrorException ex)
                 {
                     EventLogManager.Instance().LogError(ex.Message);
                 }
                 catch (InvalidSmoOperationException ex)
                 {
                     EventLogManager.Instance().LogError(ex.Message);
                 }
                 catch (SmoException ex)
                 {
                     EventLogManager.Instance().LogError(ex.Message);
                 }
             return resultDataSet;
         }

        /// <summary>
        /// This method executes the given non query and returns true on success & false on failure
        /// </summary>
        /// <param name="strCommand"></param>
        /// <returns></returns>
         public bool ExecuteSqlCommand(string strCommand)
         {
             bool bRet = true;
             try
             {
                 int i = server.ConnectionContext.ExecuteNonQuery(strCommand);
                 bRet = i == 0 ? false : true;
             }
             catch (SqlException sqlex)
             {
                 EventLogManager.Instance().LogError(sqlex.Message);
                 bRet = false;
             }
             catch (Exception ex)
             {
                 EventLogManager.Instance().LogError("Unknown error : " + ex.Message);
                 bRet = false;
             }
                
             return bRet;
         }
        /// <summary>
        /// This method executes the given sql script file
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
         public bool ExecuteSqlScript(string filename)
         {
             bool bRet = true;
             FileInfo file = new FileInfo(filename);
             if (file.Exists)
             {
                 string script = file.OpenText().ReadToEnd();
                 bRet = ExecuteSqlCommand(script);
             }
             else
             {
                 bRet = false;
             }
             return bRet;
         }


         #region IDisposable Members

         public void Dispose()
         {
             FreeConnection();
         }

         #endregion
    }
}

