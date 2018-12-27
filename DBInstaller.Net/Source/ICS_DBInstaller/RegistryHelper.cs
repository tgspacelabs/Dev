// ------------------------------------------------------------------------------------------------
// File: RegistryHelper.cs
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
using System.Diagnostics;

namespace Spacelabs.DBInstaller
{
    public class RegistryHelper : IRegistry
    {
        #region IRegistry Members
        /// <summary>
        /// Sets the specified registry key with the given value
        /// </summary>        
        /// <param name="regPath"></param>
        /// <param name="keyName"></param>
        /// <param name="regValue"></param>
        /// <returns></returns>
        public bool SetRegistryValue(string regPath, string keyName, object regValue)
        {
            RegistryKey SubKey;
            bool ret = false;
            try
            {

                SubKey = Registry.LocalMachine.OpenSubKey(regPath, true);
                if (SubKey == null)
                {
                    SubKey = Registry.LocalMachine.CreateSubKey(regPath);
                }

                if (SubKey != null)
                {
                    SubKey.SetValue(keyName, regValue);
                    SubKey.Close();
                    ret = true;
                }
            }
            catch (ArgumentNullException ex)
            {
                EventLogManager.Instance().LogError(ex.Message);
            }
            catch (UnauthorizedAccessException ex)
            {
                EventLogManager.Instance().LogError(ex.Message);
            }
            catch (ObjectDisposedException ex)
            {
                EventLogManager.Instance().LogError(ex.Message);
            }
            catch (System.Security.SecurityException ex)
            {
                EventLogManager.Instance().LogError(ex.Message);
            }
            catch (System.IO.IOException ex)
            {
                EventLogManager.Instance().LogError(ex.Message);
            }
            return ret;
        }
        /// <summary>
        /// Retrieves the specified registry key value
        /// </summary>
        /// <param name="regPath"></param>
        /// <param name="keyName"></param>
        /// <returns></returns>
        public string GetRegistryValue(string regPath, string keyName)
        {
            string keyValue = string.Empty;

            try
            {
                RegistryKey SpacelabsSubKey;
                SpacelabsSubKey = Registry.LocalMachine.OpenSubKey(regPath, false);
                keyValue = SpacelabsSubKey.GetValue(keyName, "").ToString();
                SpacelabsSubKey.Close();
            }
            catch (UnauthorizedAccessException ex)
            {
                EventLogManager.Instance().LogError(ex.Message);
            }
            catch (ObjectDisposedException ex)
            {
                EventLogManager.Instance().LogError(ex.Message);
            }
            catch (System.Security.SecurityException ex)
            {
                EventLogManager.Instance().LogError(ex.Message);
            }
            catch (System.IO.IOException ex)
            {
                EventLogManager.Instance().LogError(ex.Message);
            }

            return keyValue;
        }

        #endregion
    }
}

