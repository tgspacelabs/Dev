//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WindowsFormsApplication2
{
    using System;
    using System.Collections.Generic;
    
    public partial class Device
    {
        public int DeviceID { get; set; }
        public string DeviceName { get; set; }
        public string Model { get; set; }
        public string Type { get; set; }
        public int PatientPatientID { get; set; }
    
        public virtual Patient Patient { get; set; }
    }
}
