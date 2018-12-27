// ------------------------------------------------------------------------------------------------
// File: ISQLHelper.cs
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
using System.Data;
using System.Data.SqlClient;

namespace Spacelabs.DBInstaller
{
    public interface ISqlHelper
    {
        /// <summary>
        /// Gets the underlying sql connection object
        /// </summary>
        SqlConnection SqlConn { get; }
        /// <summary>
        /// Gets the data source name
        /// </summary>
        string DataSource { get; }
         /// <summary>
        /// Gets the connection string.
        /// </summary>
        /// <returns></returns>
        string ConnectionString { get; }
         /// <summary>
        /// Executes the given sql command and result is returned as DataSet
        /// </summary>
        /// <param name="command"></param>
        /// <returns></returns>
        DataSet ExecuteSqlCommandWithDataSet(string command);
        /// <summary>
        /// This method executes the given non query and returns true on success & false on failure
        /// </summary>
        /// <param name="strCommand"></param>
        /// <returns></returns>
        bool ExecuteSqlCommand(string command);
        /// <summary>
        /// This method executes the given sql script file
        /// </summary>
        /// <param name="fileName"></param>
        /// <returns></returns>
        bool ExecuteSqlScript(string fileName);
        /// <summary>
        /// opens database connections
        /// </summary>
        /// <returns></returns>
        bool OpenConnection();
          /// <summary>
        /// Free the database connection.
        /// </summary>
        bool FreeConnection();

    }
}

