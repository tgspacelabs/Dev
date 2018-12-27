using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace ConsoleApplicationLocalized
{
    class Program
    {
        [STAThread]
        static void Main(string[] args)
        {
            string[] myArgs = args;
            if (myArgs == null)
                myArgs[0] = "This is a test!";

            //Console.WriteLine(args.ToString());
            //Console.WriteLine();

            //Thread.CurrentThread.CurrentUICulture = CultureInfo.GetCultureInfo("en");
            //Thread.CurrentThread.CurrentUICulture = CultureInfo.GetCultureInfo("fr");
            //Thread.CurrentThread.CurrentUICulture = CultureInfo.GetCultureInfo("es");
            //Thread.CurrentThread.CurrentUICulture = CultureInfo.GetCultureInfo("it");

            //Console.WriteLine(Strings.String1);
            //Console.WriteLine(Strings.String2);
            //Console.WriteLine(Strings.String3);
            //Console.WriteLine(Strings.String4);
            //Console.WriteLine(Strings.String5);

            Console.WriteLine(Strings.CancelConfirmation);
            Console.WriteLine(Strings.ConfigSuccess);
            Console.WriteLine(Strings.ConfigurationFailed);
            Console.WriteLine(Strings.DBInstaller);
            Console.WriteLine(Strings.InvalidDBRestorePath);
            Console.WriteLine(Strings.InvalidSAPassword);
            Console.WriteLine(Strings.NoAccess);
            Console.WriteLine(Strings.NoSqlServerInstalled);
            Console.WriteLine(Strings.NoUpgradeRequired);
            Console.WriteLine(Strings.Progress_data);
            Console.WriteLine(Strings.Progress_maintjobs);
            Console.WriteLine(Strings.Progress_schema);
            Console.WriteLine(Strings.ReadyforConfiguration);
            Console.WriteLine(Strings.ReadyforUpgrade);
            Console.WriteLine(Strings.RemoteSql);
            Console.WriteLine(Strings.SpecifyValidPath);
            Console.WriteLine(Strings.UnSupportedSqlVersion);
            Console.WriteLine(Strings.UpgradeFailed);
            Console.WriteLine(Strings.UpgradeSuccessful);
            Console.WriteLine(Strings.UpgradeVersionInformation);

            Console.ReadLine();
        }
    }
}
