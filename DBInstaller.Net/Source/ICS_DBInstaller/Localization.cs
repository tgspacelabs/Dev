// ------------------------------------------------------------------------------------------------
// File: Localization.cs
// © Copyright 2013 Spacelabs Healthcare, Inc.
//
// This document contains proprietary trade secret and confidential information
// which is the property of Spacelabs Healthcare, Inc.  This document and the
// information it contains are not to be copied, distributed, disclosed to others,
// or used in any manner outside of Spacelabs Healthcare, Inc. without the prior
// written approval of Spacelabs Healthcare, Inc.
// ------------------------------------------------------------------------------------------------
//
using System.Globalization;
using System.Resources;

namespace Spacelabs.DBInstaller
{
    /// <summary>
    /// Summary description for Localization.
    /// </summary>
    public class Localization
    {
        private ResourceManager mResource;
        private string mCulture;

        public Localization(string assemblyNamespace, System.Reflection.Assembly assembly)
        {
            string file;
            mCulture = CultureInfo.CurrentCulture.Name.Substring(0, 2);

            switch (mCulture)
            {
                case "de":
                    file = @".LocalizeResx.de";
                    break;
                case "es":
                    file = @".LocalizeResx.es";
                    break;
                case "fr":
                    file = @".LocalizeResx.fr";
                    break;
                case "it":
                    file = @".LocalizeResx.it";
                    break;
                case "nl":
                    file = @".LocalizeResx.nl";
                    break;
                case "sv":
                    file = @".LocalizeResx.sv";
                    break;
                case "pl":
                    file = @".LocalizeResx.pl";
                    break;
                case "pt":
                    file = @".LocalizeResx.pt";
                    break;
                case "cs":
                    file = @".LocalizeResx.cs";
                    break;
                case "zh": //TO DO: Distinct the simplified Chinese and traditional Chinese when needed
                    file = @".LocalizeResx.zh-CHS";
                    break;
                default:
                    file = @".LocalizeResx.en";
                    break;
            }
            mResource = new ResourceManager(assemblyNamespace + file, assembly);
        }

        public ResourceManager Language
        {
            get { return mResource; }
        }

        public string Culture
        {
            get { return mCulture; }
        }
    }
}

