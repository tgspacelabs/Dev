//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WcfDataServiceLibrary
{
    using System;
    
    public partial class GetPatientByExternalIdAndDevice_Result
    {
        public System.Guid PATIENT_ID { get; set; }
        public string PATIENT_NAME { get; set; }
        public string MONITOR_NAME { get; set; }
        public string ACCOUNT_ID { get; set; }
        public string MRN_ID { get; set; }
        public Nullable<System.Guid> UNIT_ID { get; set; }
        public string UNIT_NAME { get; set; }
        public Nullable<System.Guid> FACILITY_ID { get; set; }
        public string FACILITY_NAME { get; set; }
        public Nullable<System.DateTime> DOB { get; set; }
        public Nullable<System.DateTime> ADMIT_TIME { get; set; }
        public Nullable<System.DateTime> DISCHARGED_TIME { get; set; }
        public System.Guid PATIENT_MONITOR_ID { get; set; }
        public string STATUS { get; set; }
    }
}
