using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
//using ClassLibrary1;

namespace WindowsFormsApplication2
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            CreateData();

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Form1());
        }

        static void CreateData()
        {
            using (var dbContext = new PatientDataContainer())
            {
                Device device = new Device();
                device.DeviceName = "BP monitor";
                device.Model = "Spacelabs 2000";
                device.Type = "XTR";
                dbContext.Devices.Add(device);

                Patient patient = new Patient();
                patient.FirstName = "Tony";
                patient.LastName = "Green";
                patient.Birthdate = new DateTime(1962, 8, 4);
                patient.MedicalRecordNumber = "XYZ54321";
                patient.Devices.Add(device);
                dbContext.Patients.Add(patient);

                dbContext.SaveChanges();
            }
            return;
        }
    }
}
