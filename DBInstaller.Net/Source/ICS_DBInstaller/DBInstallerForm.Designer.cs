// ------------------------------------------------------------------------------------------------
// File: DBInstallerForm.Designer.cs
// © Copyright 2013 Spacelabs Healthcare, Inc.
//
// This document contains proprietary trade secret and confidential information
// which is the property of Spacelabs Healthcare, Inc.  This document and the
// information it contains are not to be copied, distributed, disclosed to others,
// or used in any manner outside of Spacelabs Healthcare, Inc. without the prior
// written approval of Spacelabs Healthcare, Inc.
// ------------------------------------------------------------------------------------------------
//
namespace Spacelabs.DBInstaller
{
    partial class DBInstallerForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(DBInstallerForm));
            this.panelTop = new System.Windows.Forms.Panel();
            this.lblProgress = new System.Windows.Forms.Label();
            this.dbImage = new System.Windows.Forms.PictureBox();
            this.lblCaption = new System.Windows.Forms.Label();
            this.panelBottom = new System.Windows.Forms.Panel();
            this.btnBrowse = new System.Windows.Forms.Button();
            this.cmbSQLInstances = new System.Windows.Forms.ComboBox();
            this.txtDBRestorepath = new System.Windows.Forms.TextBox();
            this.txtSaPwd = new System.Windows.Forms.TextBox();
            this.txtDBPwd = new System.Windows.Forms.TextBox();
            this.txtDBUser = new System.Windows.Forms.TextBox();
            this.txtDBname = new System.Windows.Forms.TextBox();
            this.txtServerName = new System.Windows.Forms.TextBox();
            this.lblRestorepath = new System.Windows.Forms.Label();
            this.lblSaPassword = new System.Windows.Forms.Label();
            this.lblPassword = new System.Windows.Forms.Label();
            this.lblUsername = new System.Windows.Forms.Label();
            this.lblDBname = new System.Windows.Forms.Label();
            this.lblSqlInstances = new System.Windows.Forms.Label();
            this.lblServername = new System.Windows.Forms.Label();
            this.lblDatabaseInformation = new System.Windows.Forms.Label();
            this.btnBack = new System.Windows.Forms.Button();
            this.btnNext = new System.Windows.Forms.Button();
            this.btnCancel = new System.Windows.Forms.Button();
            this.lblUpgrade = new System.Windows.Forms.Label();
            this.btnConfiure = new System.Windows.Forms.Button();
            this.btnUpgrade = new System.Windows.Forms.Button();
            this.btnFinish = new System.Windows.Forms.Button();
            this.panelTop.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dbImage)).BeginInit();
            this.panelBottom.SuspendLayout();
            this.SuspendLayout();
            // 
            // panelTop
            // 
            this.panelTop.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panelTop.Controls.Add(this.lblProgress);
            this.panelTop.Controls.Add(this.dbImage);
            this.panelTop.Controls.Add(this.lblCaption);
            resources.ApplyResources(this.panelTop, "panelTop");
            this.panelTop.Name = "panelTop";
            // 
            // lblProgress
            // 
            resources.ApplyResources(this.lblProgress, "lblProgress");
            this.lblProgress.Name = "lblProgress";
            // 
            // dbImage
            // 
            resources.ApplyResources(this.dbImage, "dbImage");
            this.dbImage.Name = "dbImage";
            this.dbImage.TabStop = false;
            // 
            // lblCaption
            // 
            resources.ApplyResources(this.lblCaption, "lblCaption");
            this.lblCaption.Name = "lblCaption";
            // 
            // panelBottom
            // 
            this.panelBottom.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panelBottom.Controls.Add(this.btnBrowse);
            this.panelBottom.Controls.Add(this.cmbSQLInstances);
            this.panelBottom.Controls.Add(this.txtDBRestorepath);
            this.panelBottom.Controls.Add(this.txtSaPwd);
            this.panelBottom.Controls.Add(this.txtDBPwd);
            this.panelBottom.Controls.Add(this.txtDBUser);
            this.panelBottom.Controls.Add(this.txtDBname);
            this.panelBottom.Controls.Add(this.txtServerName);
            this.panelBottom.Controls.Add(this.lblRestorepath);
            this.panelBottom.Controls.Add(this.lblSaPassword);
            this.panelBottom.Controls.Add(this.lblPassword);
            this.panelBottom.Controls.Add(this.lblUsername);
            this.panelBottom.Controls.Add(this.lblDBname);
            this.panelBottom.Controls.Add(this.lblSqlInstances);
            this.panelBottom.Controls.Add(this.lblServername);
            this.panelBottom.Controls.Add(this.lblDatabaseInformation);
            resources.ApplyResources(this.panelBottom, "panelBottom");
            this.panelBottom.Name = "panelBottom";
            // 
            // btnBrowse
            // 
            resources.ApplyResources(this.btnBrowse, "btnBrowse");
            this.btnBrowse.Name = "btnBrowse";
            this.btnBrowse.UseVisualStyleBackColor = true;
            this.btnBrowse.Click += new System.EventHandler(this.btnBrowse_Click);
            // 
            // cmbSQLInstances
            // 
            this.cmbSQLInstances.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbSQLInstances.FormattingEnabled = true;
            resources.ApplyResources(this.cmbSQLInstances, "cmbSQLInstances");
            this.cmbSQLInstances.Name = "cmbSQLInstances";
            this.cmbSQLInstances.SelectedIndexChanged += new System.EventHandler(this.cmbSQLInstances_SelectedIndexChanged);
            // 
            // txtDBRestorepath
            // 
            resources.ApplyResources(this.txtDBRestorepath, "txtDBRestorepath");
            this.txtDBRestorepath.Name = "txtDBRestorepath";
            this.txtDBRestorepath.TextChanged += new System.EventHandler(this.txtDBRestorepath_TextChanged);
            // 
            // txtSaPwd
            // 
            resources.ApplyResources(this.txtSaPwd, "txtSaPwd");
            this.txtSaPwd.Name = "txtSaPwd";
            this.txtSaPwd.TextChanged += new System.EventHandler(this.txtSaPwd_TextChanged);
            // 
            // txtDBPwd
            // 
            resources.ApplyResources(this.txtDBPwd, "txtDBPwd");
            this.txtDBPwd.Name = "txtDBPwd";
            this.txtDBPwd.TextChanged += new System.EventHandler(this.txtDBPwd_TextChanged);
            // 
            // txtDBUser
            // 
            resources.ApplyResources(this.txtDBUser, "txtDBUser");
            this.txtDBUser.Name = "txtDBUser";
            // 
            // txtDBname
            // 
            resources.ApplyResources(this.txtDBname, "txtDBname");
            this.txtDBname.Name = "txtDBname";
            // 
            // txtServerName
            // 
            resources.ApplyResources(this.txtServerName, "txtServerName");
            this.txtServerName.Name = "txtServerName";
            // 
            // lblRestorepath
            // 
            resources.ApplyResources(this.lblRestorepath, "lblRestorepath");
            this.lblRestorepath.Name = "lblRestorepath";
            // 
            // lblSaPassword
            // 
            resources.ApplyResources(this.lblSaPassword, "lblSaPassword");
            this.lblSaPassword.Name = "lblSaPassword";
            // 
            // lblPassword
            // 
            resources.ApplyResources(this.lblPassword, "lblPassword");
            this.lblPassword.Name = "lblPassword";
            // 
            // lblUsername
            // 
            resources.ApplyResources(this.lblUsername, "lblUsername");
            this.lblUsername.Name = "lblUsername";
            // 
            // lblDBname
            // 
            resources.ApplyResources(this.lblDBname, "lblDBname");
            this.lblDBname.Name = "lblDBname";
            // 
            // lblSqlInstances
            // 
            resources.ApplyResources(this.lblSqlInstances, "lblSqlInstances");
            this.lblSqlInstances.Name = "lblSqlInstances";
            // 
            // lblServername
            // 
            resources.ApplyResources(this.lblServername, "lblServername");
            this.lblServername.Name = "lblServername";
            // 
            // lblDatabaseInformation
            // 
            resources.ApplyResources(this.lblDatabaseInformation, "lblDatabaseInformation");
            this.lblDatabaseInformation.Name = "lblDatabaseInformation";
            // 
            // btnBack
            // 
            resources.ApplyResources(this.btnBack, "btnBack");
            this.btnBack.Name = "btnBack";
            this.btnBack.UseVisualStyleBackColor = true;
            this.btnBack.Click += new System.EventHandler(this.btnBack_Click);
            // 
            // btnNext
            // 
            resources.ApplyResources(this.btnNext, "btnNext");
            this.btnNext.Name = "btnNext";
            this.btnNext.UseVisualStyleBackColor = true;
            this.btnNext.Click += new System.EventHandler(this.btnNext_Click);
            // 
            // btnCancel
            // 
            resources.ApplyResources(this.btnCancel, "btnCancel");
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // lblUpgrade
            // 
            resources.ApplyResources(this.lblUpgrade, "lblUpgrade");
            this.lblUpgrade.Name = "lblUpgrade";
            // 
            // btnConfiure
            // 
            resources.ApplyResources(this.btnConfiure, "btnConfiure");
            this.btnConfiure.Name = "btnConfiure";
            this.btnConfiure.UseVisualStyleBackColor = true;
            this.btnConfiure.Click += new System.EventHandler(this.btnConfiure_Click);
            // 
            // btnUpgrade
            // 
            resources.ApplyResources(this.btnUpgrade, "btnUpgrade");
            this.btnUpgrade.Name = "btnUpgrade";
            this.btnUpgrade.UseVisualStyleBackColor = true;
            this.btnUpgrade.Click += new System.EventHandler(this.btnUpgrade_Click);
            // 
            // btnFinish
            // 
            resources.ApplyResources(this.btnFinish, "btnFinish");
            this.btnFinish.Name = "btnFinish";
            this.btnFinish.UseVisualStyleBackColor = true;
            this.btnFinish.Click += new System.EventHandler(this.btnFinish_Click);
            // 
            // DBInstallerForm
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ControlBox = false;
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnBack);
            this.Controls.Add(this.panelBottom);
            this.Controls.Add(this.panelTop);
            this.Controls.Add(this.lblUpgrade);
            this.Controls.Add(this.btnFinish);
            this.Controls.Add(this.btnNext);
            this.Controls.Add(this.btnUpgrade);
            this.Controls.Add(this.btnConfiure);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "DBInstallerForm";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.TopMost = true;
            this.Load += new System.EventHandler(this.DBInstallerForm_Load);
            this.panelTop.ResumeLayout(false);
            this.panelTop.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dbImage)).EndInit();
            this.panelBottom.ResumeLayout(false);
            this.panelBottom.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel panelTop;
        private System.Windows.Forms.Panel panelBottom;
        private System.Windows.Forms.Button btnBack;
        private System.Windows.Forms.Button btnNext;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.Button btnBrowse;
        private System.Windows.Forms.Label lblCaption;
        private System.Windows.Forms.Label lblRestorepath;
        private System.Windows.Forms.Label lblSaPassword;
        private System.Windows.Forms.Label lblPassword;
        private System.Windows.Forms.Label lblUsername;
        private System.Windows.Forms.Label lblDBname;
        private System.Windows.Forms.Label lblSqlInstances;
        private System.Windows.Forms.Label lblServername;
        private System.Windows.Forms.Label lblDatabaseInformation;
        private System.Windows.Forms.TextBox txtDBRestorepath;
        private System.Windows.Forms.TextBox txtSaPwd;
        private System.Windows.Forms.TextBox txtDBPwd;
        private System.Windows.Forms.TextBox txtDBUser;
        private System.Windows.Forms.TextBox txtDBname;
        private System.Windows.Forms.TextBox txtServerName;
        private System.Windows.Forms.ComboBox cmbSQLInstances;
        private System.Windows.Forms.PictureBox dbImage;
        private System.Windows.Forms.Label lblProgress;
        private System.Windows.Forms.Label lblUpgrade;
        private System.Windows.Forms.Button btnConfiure;
        private System.Windows.Forms.Button btnUpgrade;
        private System.Windows.Forms.Button btnFinish;


    }
}

