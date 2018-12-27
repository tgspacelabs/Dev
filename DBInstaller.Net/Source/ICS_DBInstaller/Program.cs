// ------------------------------------------------------------------------------------------------
// File: Program.cs
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
using System.Globalization;
using System.Linq;
using System.Windows.Forms;
using System.Reflection;

namespace Spacelabs.DBInstaller
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            // for now we force the culture to be "en-us"
            System.Threading.Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");
            System.Threading.Thread.CurrentThread.CurrentUICulture = new CultureInfo("en-US");

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            //localization support
            Localization resource = new Localization(typeof(DBInstallerForm).Namespace, Assembly.GetExecutingAssembly());

            if (!CommonUtility.IsSqlInstalledLocally())
            {
                MessageBox.Show(resource.Language.GetString("NoSqlServerInstalled"), resource.Language.GetString("DBInstaller"), MessageBoxButtons.OK, MessageBoxIcon.Error, MessageBoxDefaultButton.Button1,0);
                return;
            }
            Application.Run(new DBInstallerForm(resource));
        }
    }
}

