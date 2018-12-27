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
    using System.Collections.Generic;
    
    public partial class int_12lead_report_new
    {
        public System.Guid patient_id { get; set; }
        public System.Guid report_id { get; set; }
        public System.DateTime report_dt { get; set; }
        public Nullable<short> version_number { get; set; }
        public string patient_name { get; set; }
        public string id_number { get; set; }
        public string birthdate { get; set; }
        public string age { get; set; }
        public string sex { get; set; }
        public string height { get; set; }
        public string weight { get; set; }
        public string report_date { get; set; }
        public string report_time { get; set; }
        public Nullable<int> vent_rate { get; set; }
        public Nullable<int> pr_interval { get; set; }
        public Nullable<int> qt { get; set; }
        public Nullable<int> qtc { get; set; }
        public Nullable<int> qrs_duration { get; set; }
        public Nullable<int> p_axis { get; set; }
        public Nullable<int> qrs_axis { get; set; }
        public Nullable<int> t_axis { get; set; }
        public string interpretation { get; set; }
        public int sample_rate { get; set; }
        public int sample_count { get; set; }
        public int num_Ypoints { get; set; }
        public int baseline { get; set; }
        public int Ypoints_per_unit { get; set; }
        public byte[] waveform_data { get; set; }
        public Nullable<short> send_request { get; set; }
        public Nullable<short> send_complete { get; set; }
        public Nullable<System.DateTime> send_dt { get; set; }
        public string interpretation_edits { get; set; }
        public Nullable<System.Guid> user_id { get; set; }
        public System.DateTime CreateDate { get; set; }
    
        public virtual int_12lead_report int_12lead_report { get; set; }
    }
}
