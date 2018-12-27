// ------------------------------------------------------------------------------------------------
// File: DBInstallerForm.cs
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
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Diagnostics;
using System.Collections.ObjectModel;
using System.Globalization;

namespace Spacelabs.DBInstaller
{
    public delegate bool AsyncCallConfigure();
    public delegate bool AsyncCallUpgrade();
    public delegate void SetProgressText(string text);
    public delegate void ActionCompleted(bool status);
    

    public partial class DBInstallerForm : Form, IDBInstall
    {
        #region Declarations
        
        IRegistry regHelper = null;
        DBInstallPresenter presenter = null;
        AsyncCallConfigure asyncConfigure = null;
        AsyncCallUpgrade asyncUpgrade = null;
        SetProgressText SetPText = null;
        ActionCompleted OnConfigurationCompleteEvent = null, OnUpgradeCompleteEvent = null;
        Localization resource = null;
        InstallType installType = InstallType.None;
        #endregion Declarations

        #region C'tor

        public DBInstallerForm(Localization res)
        {
            InitializeComponent();

            //localization support
            resource = res;
            regHelper = new RegistryHelper();
            EventLogManager.Instance().Logger = new EventLogger();
            SetPText = new SetProgressText(SetText);
            presenter = new DBInstallPresenter(this, regHelper, resource);
            asyncConfigure = new AsyncCallConfigure(Configure);
            asyncUpgrade = new AsyncCallUpgrade(Upgrade);
            OnConfigurationCompleteEvent = new ActionCompleted(OnConfigurationComplete);
            OnUpgradeCompleteEvent = new ActionCompleted(OnUpgradeComplete);
            presenter.ReportProgress += new EventHandler<ReportProgressEventArgs>(presenter_ReportProgress);
            presenter.SelectInstance += new EventHandler<SelectSqlInstanceEventArgs>(presenter_SelectInstance);
        }         

        #endregion C'tor        
               
        #region UI Event handlers
        /// <summary>
        /// Event handler that sets the selected sql instance from presenter. this will be called for first time when the settings were loaded from registry
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void presenter_SelectInstance(object sender, SelectSqlInstanceEventArgs e)
        {
            int index = GetInstanceIndex(e.InstanceName);
            if (index != -1 && index <= cmbSQLInstances.Items.Count - 1)
            {
                cmbSQLInstances.SelectedIndex = index;
            }
        }     
        /// <summary>
        /// Sets the progress message of the configuration action
        /// </summary>
        /// <param name="text"></param>
        void SetText(string text)
        {
            lblProgress.Text = text;
            this.Update();            
        }
        /// <summary>
        /// Event handler for reporting progress from presenter
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void presenter_ReportProgress(object sender, ReportProgressEventArgs e)
        {
            object[] str = new object[1];
            str[0] = e.ProgressText;
            this.BeginInvoke(SetPText, str);
        }
        /// <summary>
        /// Event handler for finish button click action after successful configuration
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnFinish_Click(object sender, EventArgs e)
        {
            //some final stuff and freeing the sql connection
            if (installType == InstallType.Configure)
            {
                if (!OnFinish())
                {
                    DisplayMessageBox(resource.Language.GetString("ConfigurationFailed"), MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }

            this.Close();
        }
        /// <summary>
        /// Event handler for Cancel button click. Alerts the user with YesNo message box to quit the application
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnCancel_Click(object sender, EventArgs e)
        {
            DialogResult dr = DisplayMessageBox(resource.Language.GetString("CancelConfirmation"), MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
            if (dr == System.Windows.Forms.DialogResult.Yes)
            {
                this.Close();
            }
        }
        /// <summary>
        /// Event handler for next button click. Initializes and prepares for configuration
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnNext_Click(object sender, EventArgs e)
        {
            string DataSource = CommonUtility.GetDataSourceNameFromInstanceName(CommonUtility.GetActualSqlInstanceName(cmbSQLInstances.SelectedItem.ToString()));
            using (SQLHelper helper = new SQLHelper(DataSource, SAPassword))
            {
                if (OnNextButtonClick(helper as ISqlHelper))
                {
                    installType = presenter.DetectUpgrade();
                    switch (installType)
                    {
                        case InstallType.Configure:
                            //configure actions
                            this.btnNext.Visible = false;
                            this.btnBack.Enabled = true;
                            this.panelBottom.Visible = false;
                            this.btnConfiure.Visible = true;
                            this.btnConfiure.Enabled = true;
                            this.btnConfiure.BringToFront();
                            this.lblUpgrade.Text = string.Empty;
                            this.lblUpgrade.Visible = false;
                            SetPText(resource.Language.GetString("ReadyforConfiguration"));
                            break;
                        case InstallType.Upgrade:
                            //upgrade actions
                            this.btnNext.Visible = false;
                            this.btnConfiure.Visible = false;
                            this.btnBack.Enabled = true;
                            this.panelBottom.Visible = false;
                            this.btnUpgrade.Visible = true;
                            this.btnUpgrade.Enabled = true;
                            this.btnUpgrade.BringToFront();
                            this.lblUpgrade.Text = string.Format(CultureInfo.CurrentCulture, resource.Language.GetString("UpgradeVersionInformation"),presenter.InstalledVersion, presenter.InstallingVersion);
                            this.lblUpgrade.Visible = true;
                            SetPText(resource.Language.GetString("ReadyforUpgrade"));
                            break;
                        case InstallType.None:
                        default:
                            this.panelBottom.Visible = false;
                            this.btnBack.Enabled = true;
                            this.btnFinish.Enabled = true;
                            this.btnFinish.Visible = true;
                            this.btnNext.Visible = false;
                            this.btnFinish.BringToFront();
                            SetPText(resource.Language.GetString("NoUpgradeRequired"));
                            DisplayMessageBox(resource.Language.GetString("NoUpgradeRequired"), MessageBoxButtons.OK, MessageBoxIcon.Information);
                            break;                            
                    }
                }
            }
        }
        /// <summary>
        /// Event handler for Configure button click. Initiates the configuration action.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnConfiure_Click(object sender, EventArgs e)
        {
            //proceed with the installation.
            this.btnBack.Enabled = false;
            this.btnConfiure.Enabled = false;
            this.btnCancel.Enabled = false;           
            asyncConfigure.BeginInvoke(new AsyncCallback(ConfigurationCompleted), this);
        }
        /// <summary>
        /// Event handler for Back button. Navigates the user to previous page to correct any input
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnBack_Click(object sender, EventArgs e)
        {
            this.panelBottom.Visible = true;
            this.btnBack.Enabled = false;
            this.btnNext.Enabled = true;
            this.btnNext.Visible = true;
            this.btnNext.BringToFront();
            this.btnConfiure.Enabled = false;
            this.btnConfiure.Visible = false;
            this.btnCancel.Visible = true;
            this.btnCancel.BringToFront();
            this.lblProgress.Text = string.Empty;
        }        
        /// <summary>
        /// Event handler for password change
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void txtDBPwd_TextChanged(object sender, EventArgs e)
        {
            DBPassword = this.txtDBPwd.Text;
            EnableNextButton();
        }
        /// <summary>
        /// Event handler for Sa password change
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void txtSaPwd_TextChanged(object sender, EventArgs e)
        {
            SAPassword = this.txtSaPwd.Text;
            EnableNextButton();
        }
        /// <summary>
        /// Event handler for database restore path change
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void txtDBRestorepath_TextChanged(object sender, EventArgs e)
        {
            DBRestorePath = this.txtDBRestorepath.Text;
            EnableNextButton();
        }
        /// <summary>
        /// Event handler for Sql instance change
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cmbSQLInstances_SelectedIndexChanged(object sender, EventArgs e)
        {
            ComboBox cmb = sender as ComboBox;
            if (cmb != null && cmb.SelectedIndex != -1)
            {
                SelectedSqlInstance = cmb.SelectedItem.ToString();
                presenter.SelectedSqlInstanceChanged(SelectedSqlInstance);
            }
        }
        /// <summary>
        /// Triggers the Init method that initializes previous configuration settings from registry, if available
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void DBInstallerForm_Load(object sender, EventArgs e)
        {
            Init();
        }
        /// <summary>
        /// Event handler for Browse button click. Opens the 'Browse for Folder' windows common dialog to let the user select the particular folder.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnBrowse_Click(object sender, EventArgs e)
        {
            using (FolderBrowserDialog dlg = new FolderBrowserDialog())
            {
                dlg.SelectedPath = txtDBRestorepath.Text;
                DialogResult result = dlg.ShowDialog();

                if (result == DialogResult.OK)
                {
                    txtDBRestorepath.Text = dlg.SelectedPath;
                }
            }
        }

        #endregion UI Event handlers

        #region IDBInstall Members

        #region Properties
        /// <summary>
        /// Gets or sets server name
        /// </summary>
        public string ServerName
        {
            get
            {
                return presenter.ServerName;
            }
            set
            {
                presenter.ServerName = value;
            }
        }
        /// <summary>
        /// Gets or sets selected Sql instance
        /// </summary>
        public string SelectedSqlInstance
        {
            get
            {
                return presenter.SelectedSqlInstance;
            }
            set
            {
                presenter.SelectedSqlInstance = value;
            }
        }
        /// <summary>
        /// Gets or sets database name
        /// </summary>
        public string DatabaseName
        {
            get
            {
                return presenter.DatabaseName;
            }
            set
            {
                presenter.DatabaseName = value;
            }
        }
        /// <summary>
        /// Gets or sets password
        /// </summary>
        public string DBPassword
        {
            get
            {
                return presenter.DBPassword;
            }
            set
            {
                presenter.DBPassword = value;
            }
        }
        /// <summary>
        /// Gets or sets user name
        /// </summary>
        public string DBUserName
        {
            get
            {
                return presenter.DBUserName;
            }
            set
            {
                presenter.DBUserName = value;
            }
        }
        /// <summary>
        /// Gets or sets Sa password
        /// </summary>
        public string SAPassword
        {
            get
            {
                return presenter.SAPassword;
            }
            set
            {
                presenter.SAPassword = value;
            }
        }
        /// <summary>
        /// Gets or sets database restore path
        /// </summary>
        public string DBRestorePath
        {
            get
            {
                return presenter.DBRestorePath;
            }
            set
            {
                presenter.DBRestorePath = value;
            }
        }

        #endregion

        #region Methods
        /// <summary>
        /// Invokes the presenter's implementation of OnFinish
        /// </summary>
        /// <returns></returns>
        public bool OnFinish()
        {
            return presenter.OnFinish();
        }
        /// <summary>
        /// Invokes presenter's implementation of Configure
        /// </summary>
        /// <returns></returns>
        public bool Configure()
        {
            return presenter.Configure();
        }
        
        /// <summary>
        /// Updates the UI from presenter
        /// </summary>
        public void UpdateUI()
        {
            //to the UI
            this.txtServerName.Text = ServerName;
            this.txtDBname.Text = DatabaseName;
            this.txtDBUser.Text = DBUserName;
            this.txtDBPwd.Text = DBPassword;
            this.txtSaPwd.Text = SAPassword;
        }     

        /// <summary>
        /// Invokes the presenter implementation of OnNextButtonClick
        /// </summary>
        /// <param name="sqlHelper"></param>
        /// <returns></returns>
        public bool OnNextButtonClick(ISqlHelper sqlHelper)
        {
            return presenter.OnNextButtonClick(sqlHelper);
        }

        /// <summary>
        /// Displays the message to the user
        /// </summary>
        /// <param name="message">message</param>
        /// <param name="caption">caption</param>
        /// <param name="buttons">buttons</param>
        /// <param name="icon">icon</param>
        /// <returns>dialog result</returns>
        public DialogResult DisplayMessageBox(string message,MessageBoxButtons buttons, MessageBoxIcon icon)
        {
            return MessageBox.Show(message, resource.Language.GetString("DBInstaller"), buttons, icon, MessageBoxDefaultButton.Button1, 0);
        }

        public void Init()
        {
            //load sql instances
            foreach (string instancename in CommonUtility.InstalledSqlInstances)
            {
                this.cmbSQLInstances.Items.Add(instancename);
            }
            // load initial settings from registry
            presenter.LoadSettingsFromRegistry();            
        }       
        /// <summary>
        /// Updates the restore path upon selected SQL instance is changed
        /// </summary>
        /// <param name="restorePath"></param>
        public void UpdateSqlRestorePath(string restorePath)
        {
            this.txtDBRestorepath.Text = restorePath;
            EnableNextButton();
        }

        #endregion

        #endregion IDBInstall Members

        #region Private Methods
        /// <summary>
        /// retrieves the index of an instance in the combo box
        /// </summary>
        /// <param name="instance"></param>
        /// <returns></returns>
        int GetInstanceIndex(string instance)
        {
            int index = -1;
            foreach (string item in cmbSQLInstances.Items)
            {
                if (item.ToUpperInvariant().Equals(instance.ToUpperInvariant()))
                {
                    index = cmbSQLInstances.Items.IndexOf(item);
                    break;
                }
            }
            return index;
        }
        /// <summary>
        /// Validates all the configuration fields and enables the Next button accordingly
        /// </summary>
        void EnableNextButton()
        {
            if (!string.IsNullOrEmpty(ServerName) &&
                !string.IsNullOrEmpty(SelectedSqlInstance) &&
                !string.IsNullOrEmpty(DatabaseName) &&
                !string.IsNullOrEmpty(DBUserName) &&
                !string.IsNullOrEmpty(DBPassword) &&
                !string.IsNullOrEmpty(SAPassword) &&
                !string.IsNullOrEmpty(DBRestorePath))
            {
                this.btnNext.Enabled = true;
            }
            else
            {
                this.btnNext.Enabled = false;
            }
        }
        /// <summary>
        /// Call back after the configuration is completed which was invoked asynchronously
        /// </summary>
        /// <param name="result"></param>
        private void ConfigurationCompleted(IAsyncResult result) 
        {
            try     
            {         
                bool configurationStatus = asyncConfigure.EndInvoke(result);               
                object[] args = new object[1];
                args[0] = configurationStatus;
                this.BeginInvoke(OnConfigurationCompleteEvent, args);
            }     
            catch (InvalidOperationException ex)     
            {
                EventLogManager.Instance().LogError(ex.Message);
            } 
        }       
        /// <summary>
        /// Delegate method that handles post configuration
        /// </summary>
        /// <param name="status"></param>
        void OnConfigurationComplete(bool status)
        {
            if (status)
            {
                //succeeded
                //end of the installation
                this.btnCancel.Visible = false;
                this.btnCancel.Enabled = false;
                
                this.btnFinish.Visible = true;
                this.btnFinish.Enabled = true;
                this.btnFinish.BringToFront();
            }
            else
            {
                //configuration failed
                this.btnBack.Enabled = true;
                this.btnConfiure.Enabled = true;
                this.btnCancel.Visible = true;
                this.btnCancel.Enabled = true;
                this.btnCancel.BringToFront();
                DisplayMessageBox(resource.Language.GetString("ConfigurationFailed"), System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Error);
            }
        }

        #endregion Private Methods        

        #region Upgrade methods

        private void btnUpgrade_Click(object sender, EventArgs e)
        {
            //proceed with the installation.
            this.btnBack.Enabled = false;
            this.btnUpgrade.Enabled = false;
            this.btnCancel.Enabled = false;
            asyncUpgrade.BeginInvoke(new AsyncCallback(UpgradeCompleted), this);
        }
        /// <summary>
        /// Invokes presenter's implementation of Upgrade asynchronously
        /// </summary>
        /// <returns></returns>
        public bool Upgrade()
        {
            return presenter.Upgrade();
        }
        /// <summary>
        /// Call back after the configuration is completed which was invoked asynchronously
        /// </summary>
        /// <param name="result"></param>
        private void UpgradeCompleted(IAsyncResult result)
        {
            try
            {
                bool upgradeStatus = asyncUpgrade.EndInvoke(result);
                object[] args = new object[1];
                args[0] = upgradeStatus;
                this.BeginInvoke(OnUpgradeCompleteEvent, args);
            }
            catch (InvalidOperationException ex)
            {
                EventLogManager.Instance().LogError(ex.Message);
            }
        }
        /// <summary>
        /// Delegate method that handles post upgrade
        /// </summary>
        /// <param name="status"></param>
        void OnUpgradeComplete(bool status)
        {
            if (status)
            {
                //succeeded
                //end of the installation
                this.btnCancel.Visible = false;
                this.btnCancel.Enabled = false;
                this.lblUpgrade.Visible = false;
                this.btnFinish.Visible = true;
                this.btnFinish.Enabled = true;
                this.btnFinish.BringToFront();
            }
            else
            {
                //configuration failed
                this.btnBack.Enabled = true;
                this.btnConfiure.Enabled = true;
                this.btnCancel.Visible = true;
                this.btnCancel.Enabled = true;
                this.btnCancel.BringToFront();
                SetText(string.Format(CultureInfo.CurrentCulture, resource.Language.GetString("UpgradeFailed"), presenter.InstallingVersion));
                DisplayMessageBox(string.Format(CultureInfo.CurrentCulture, resource.Language.GetString("UpgradeFailed"), presenter.InstallingVersion), System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Error);
            }
        }

        #endregion Upgrade methods
    }
}


