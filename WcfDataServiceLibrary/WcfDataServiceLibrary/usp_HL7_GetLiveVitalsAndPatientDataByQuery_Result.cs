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
    
    public partial class usp_HL7_GetLiveVitalsAndPatientDataByQuery_Result
    {
        public Nullable<System.DateTime> DateOfBirth { get; set; }
        public Nullable<int> GenderCd { get; set; }
        public Nullable<System.DateTime> DeathDate { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string AccountNumber { get; set; }
        public string MRN { get; set; }
        public System.Guid patient_id { get; set; }
        public Nullable<System.Guid> DeviceId { get; set; }
    }
}
