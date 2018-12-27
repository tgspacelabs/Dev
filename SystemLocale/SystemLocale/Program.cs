using System;
using System.Globalization;

namespace SystemLocale
{
    class Program
    {
        static void Main(string[] args)
        {
            //Localization loc = null;
            Console.WriteLine(CultureInfo.CurrentCulture.TwoLetterISOLanguageName);
            Console.WriteLine(CultureInfo.CurrentCulture.ThreeLetterISOLanguageName);
            Console.WriteLine(CultureInfo.CurrentCulture.ThreeLetterWindowsLanguageName);
            Console.WriteLine(CultureInfo.CurrentCulture.Name);
            Console.WriteLine(CultureInfo.CurrentCulture.NativeName);
            Console.WriteLine(CultureInfo.CurrentCulture.LCID);
            Console.WriteLine(@"");
            Console.WriteLine(nameof(SystemLocale) + @" - " + SystemLocale);
            
            Console.ReadLine();
        }

        /// <summary>
        /// Gets the system locale
        /// </summary>
        public static string SystemLocale
        {
            get
            {
                string threeLetterLocaleName = "ENU";

                CultureInfo cInfo = CultureInfo.CurrentCulture;
                switch (cInfo.TwoLetterISOLanguageName)
                {
                    case "zh":
                        //dbLanguage = "Chinese Simplified";
                        threeLetterLocaleName = "CHS";
                        break;
                    case "cs":
                        //dbLanguage = "Czech";
                        threeLetterLocaleName = "CZE";
                        break;
                    case "nl":
                        //dbLanguage = "Dutch";
                        threeLetterLocaleName = "NLD";
                        break;
                    case "fr":
                        //dbLanguage = "French";
                        threeLetterLocaleName = "FRA";
                        break;
                    case "de":
                        //dbLanguage = "German";
                        threeLetterLocaleName = "DEU";
                        break;
                    case "it":
                        //dbLanguage = "Italian";
                        threeLetterLocaleName = "ITA";
                        break;
                    case "pl":
                        //dbLanguage = "Polish";
                        threeLetterLocaleName = "POL";
                        break;
                    case "pt":
                        //dbLanguage = "Portuguese";
                        threeLetterLocaleName = "PTB";
                        break;
                    case "es":
                        //dbLanguage = "Spanish";
                        threeLetterLocaleName = "ESP";
                        break;
                    case "sv":
                        //dbLanguage = "Swedish";
                        threeLetterLocaleName = "SWE";
                        break;
                    default:
                        //dbLanguage = "English";
                        threeLetterLocaleName = "ENU";
                        break;
                }

                return threeLetterLocaleName;
            }
        }
    }
}
