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
    using System.Collections.Generic;
    
    public partial class int_patient
    {
        public System.Guid patient_id { get; set; }
        public Nullable<System.Guid> new_patient_id { get; set; }
        public string organ_donor_sw { get; set; }
        public string living_will_sw { get; set; }
        public Nullable<byte> birth_order { get; set; }
        public Nullable<int> veteran_status_cid { get; set; }
        public string birth_place { get; set; }
        public string ssn { get; set; }
        public Nullable<int> mpi_ssn1 { get; set; }
        public Nullable<int> mpi_ssn2 { get; set; }
        public Nullable<int> mpi_ssn3 { get; set; }
        public Nullable<int> mpi_ssn4 { get; set; }
        public string driv_lic_no { get; set; }
        public string mpi_dl1 { get; set; }
        public string mpi_dl2 { get; set; }
        public string mpi_dl3 { get; set; }
        public string mpi_dl4 { get; set; }
        public string driv_lic_state_code { get; set; }
        public Nullable<System.DateTime> dob { get; set; }
        public Nullable<System.DateTime> death_dt { get; set; }
        public Nullable<int> nationality_cid { get; set; }
        public Nullable<int> citizenship_cid { get; set; }
        public Nullable<int> ethnic_group_cid { get; set; }
        public Nullable<int> race_cid { get; set; }
        public Nullable<int> gender_cid { get; set; }
        public Nullable<int> primary_language_cid { get; set; }
        public Nullable<int> marital_status_cid { get; set; }
        public Nullable<int> religion_cid { get; set; }
        public Nullable<int> monitor_interval { get; set; }
        public Nullable<double> height { get; set; }
        public Nullable<double> weight { get; set; }
        public Nullable<double> bsa { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}
