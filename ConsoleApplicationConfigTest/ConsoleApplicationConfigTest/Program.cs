using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

namespace ConsoleApplicationConfigTest
{
    class Program
    {
        static void Main(string[] args)
        {
            //var appSettings = ConfigurationManager.AppSettings;
            //string value = appSettings.Get("abc").ToString();
            ReadAllSettings();
        }

        static void ReadAllSettings()
        {
            try
            {
                var appSettings = ConfigurationManager.AppSettings;
                //string setting = Properties.Settings.Default.Setting;
                SettingsPropertyCollection settings = Properties.Settings.Default.Properties;

                foreach(System.Configuration.SettingsProperty setting in settings)
                {
                    Console.WriteLine("Setting Name: {0}  Value: {1}", setting.Name, setting.DefaultValue);
                }

                if (appSettings.Count == 0)
                {
                    Console.WriteLine("AppSettings is empty.");
                }
                else
                {
                    foreach (var key in appSettings.AllKeys)
                    {
                        Console.WriteLine("Key: {0} Value: {1}", key, appSettings[key]);
                    }
                }
            }
            catch (ConfigurationErrorsException)
            {
                Console.WriteLine("Error reading app settings");
            }
        }
    }
}
