// ------------------------------------------------------------------------------------------------
// File: IRegistry.cs
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

namespace Spacelabs.DBInstaller
{
    public interface IRegistry
    {
        /// <summary>
        /// Sets the specified registry key with the given value
        /// </summary>        
        /// <param name="regPath"></param>
        /// <param name="keyName"></param>
        /// <param name="regValue"></param>
        /// <returns></returns>
        bool SetRegistryValue(string regPath, string keyName, object regValue);
        /// <summary>
        /// Retrieves the specified registry key value
        /// </summary>
        /// <param name="regPath"></param>
        /// <param name="keyName"></param>
        /// <returns></returns>
        string GetRegistryValue(string regPath, string keyName);
    }
}

