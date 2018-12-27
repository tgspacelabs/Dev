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
    
    public partial class int_encounter
    {
        public System.Guid encounter_id { get; set; }
        public Nullable<System.Guid> organization_id { get; set; }
        public Nullable<System.DateTime> mod_dt { get; set; }
        public Nullable<System.Guid> patient_id { get; set; }
        public Nullable<System.Guid> orig_patient_id { get; set; }
        public Nullable<System.Guid> account_id { get; set; }
        public string status_cd { get; set; }
        public Nullable<int> publicity_cid { get; set; }
        public Nullable<int> diet_type_cid { get; set; }
        public Nullable<int> patient_class_cid { get; set; }
        public Nullable<int> protection_type_cid { get; set; }
        public string vip_sw { get; set; }
        public Nullable<int> isolation_type_cid { get; set; }
        public Nullable<int> security_type_cid { get; set; }
        public Nullable<int> patient_type_cid { get; set; }
        public Nullable<System.Guid> admit_hcp_id { get; set; }
        public Nullable<int> med_svc_cid { get; set; }
        public Nullable<System.Guid> referring_hcp_id { get; set; }
        public Nullable<System.Guid> unit_org_id { get; set; }
        public Nullable<System.Guid> attend_hcp_id { get; set; }
        public Nullable<System.Guid> primary_care_hcp_id { get; set; }
        public Nullable<int> fall_risk_type_cid { get; set; }
        public Nullable<System.DateTime> begin_dt { get; set; }
        public Nullable<int> ambul_status_cid { get; set; }
        public Nullable<System.DateTime> admit_dt { get; set; }
        public string baby_cd { get; set; }
        public string rm { get; set; }
        public string recurring_cd { get; set; }
        public string bed { get; set; }
        public Nullable<System.DateTime> discharge_dt { get; set; }
        public string newborn_sw { get; set; }
        public Nullable<int> discharge_dispo_cid { get; set; }
        public Nullable<byte> monitor_created { get; set; }
        public string comment { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}
