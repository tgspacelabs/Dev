// ------------------------------------------------------------------------------------------------
// File: IDBInstall.cs
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
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Spacelabs.DBInstaller
{
    /// <summary>
    /// Class that carries progress text as argument from  presenter to view
    /// </summary>
    public class ReportProgressEventArgs : EventArgs
    {
        string progressText;
        public string ProgressText { get { return progressText; } }
        public ReportProgressEventArgs(string text)
        {
            progressText = text;
        }
    }
    /// <summary>
    /// Class that carries arguments from  presenter to view when a specific item to be selected in the instance combo box
    /// </summary>
    public class SelectSqlInstanceEventArgs : EventArgs
    {
        string instanceName;
        public string InstanceName { get { return instanceName; } }
        public SelectSqlInstanceEventArgs(string name)
        {
            instanceName = name;
        }
    }

    public interface IDBInstall
    {
        /// <summary>
        /// Gets or sets the Servername or IP address of the machine hosting the database server
        /// </summary>
        string ServerName { get; set; }
        /// <summary>
        /// Gets or sets the selected SQL instance
        /// </summary>
        string SelectedSqlInstance { get; set; }
        /// <summary>
        /// Gets or sets the ICS database name
        /// </summary>
        string DatabaseName { get; set; }
        /// <summary>
        /// Gets or sets the ICS database password
        /// </summary>
        string DBPassword { get; set; }
        /// <summary>
        /// Gets or sets the ICS database username
        /// </summary>
        string DBUserName { get; set; }
        /// <summary>
        /// Gets or sets the SA password
        /// </summary>
        string SAPassword { get; set; }
        /// <summary>
        /// Gets or sets the ICS database restoration path
        /// </summary>
        string DBRestorePath { get; set; }
        /// <summary>
        /// Updates UI with the field values
        /// </summary>
        void UpdateUI();
        /// <summary>
        /// Entry point for portal database configuration
        /// </summary>
        bool OnNextButtonClick(ISqlHelper sqlHelper);
        /// <summary>
        /// Method to display windows user message box. This method gives the flexibility to mock it while
        /// writing automated unit tests.
        /// </summary>
        /// <param name="message"></param>
        /// <param name="caption"></param>
        /// <param name="buttons"></param>
        /// <param name="icon"></param>
        /// <returns></returns>
        DialogResult DisplayMessageBox(string message, MessageBoxButtons buttons, MessageBoxIcon icon);
        /// <summary>
        /// Loads the initial settings from registry
        /// </summary>
        void Init();
        /// <summary>
        /// Updates the restore path in UI upon sql instance selection change.
        /// </summary>
        /// <param name="restorePath"></param>
        void UpdateSqlRestorePath(string restorePath);        
        /// <summary>
        /// Executes the database creation and configuration actions
        /// </summary>        
        /// <returns>true if succeeds, false otherwise</returns>
        bool Configure();
        /// <summary>
        /// Method to perform cleanup actions after successful configuration
        /// </summary>
        /// <returns></returns>
        bool OnFinish();        
    }
}

