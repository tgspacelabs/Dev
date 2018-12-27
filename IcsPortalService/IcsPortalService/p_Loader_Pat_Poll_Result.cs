//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace IcsPortalService
{
    using System;
    
    public partial class p_Loader_Pat_Poll_Result
    {
        public string mrn_xid { get; set; }
        public string mrn_xid2 { get; set; }
        public System.Guid patient_id { get; set; }
        public Nullable<System.DateTime> dob { get; set; }
        public Nullable<int> gender_cid { get; set; }
        public Nullable<double> height { get; set; }
        public Nullable<double> weight { get; set; }
        public Nullable<double> bsa { get; set; }
        public string last_nm { get; set; }
        public string first_nm { get; set; }
        public string middle_nm { get; set; }
        public System.Guid patient_monitor_id { get; set; }
        public Nullable<int> monitor_interval { get; set; }
        public Nullable<System.DateTime> monitor_connect_dt { get; set; }
        public Nullable<System.DateTime> last_poll_dt { get; set; }
        public Nullable<System.DateTime> last_result_dt { get; set; }
        public Nullable<System.DateTime> last_episodic_dt { get; set; }
        public Nullable<System.DateTime> poll_start_dt { get; set; }
        public Nullable<System.DateTime> poll_end_dt { get; set; }
        public string monitor_status { get; set; }
        public string monitor_error { get; set; }
        public Nullable<System.Guid> encounter_id { get; set; }
        public Nullable<System.DateTime> live_until_dt { get; set; }
        public string network_id { get; set; }
        public System.Guid monitor_id { get; set; }
        public string monitor_name { get; set; }
        public string node_id { get; set; }
        public string bed_id { get; set; }
        public string room { get; set; }
        public string monitor_type_cd { get; set; }
        public Nullable<System.Guid> unit_org_id { get; set; }
        public Nullable<int> outbound_interval { get; set; }
        public string organization_cd { get; set; }
    }
}