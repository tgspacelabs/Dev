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
    
    public partial class usp_DM3_GetGatewayDetails_Result
    {
        public System.Guid gateway_id { get; set; }
        public string gateway_type { get; set; }
        public string network_id { get; set; }
        public string hostname { get; set; }
        public Nullable<byte> enable_sw { get; set; }
        public string recv_app { get; set; }
        public string send_app { get; set; }
        public Nullable<int> reconnect_secs { get; set; }
        public Nullable<System.Guid> organization_id { get; set; }
        public Nullable<System.Guid> send_sys_id { get; set; }
        public Nullable<int> results_usid { get; set; }
        public Nullable<int> sleep_secs { get; set; }
        public Nullable<byte> add_monitors_sw { get; set; }
        public Nullable<byte> add_patients_sw { get; set; }
        public Nullable<byte> add_results_sw { get; set; }
        public Nullable<int> debug_level { get; set; }
        public Nullable<System.Guid> unit_org_id { get; set; }
        public string patient_id_type { get; set; }
        public Nullable<byte> auto_assign_id_sw { get; set; }
        public string new_mrn_format { get; set; }
        public Nullable<byte> auto_chan_attach_sw { get; set; }
        public Nullable<byte> live_vitals_sw { get; set; }
        public Nullable<int> live_waveform_size { get; set; }
        public Nullable<int> decnet_node { get; set; }
        public string node_name { get; set; }
        public string nodes_excluded { get; set; }
        public string nodes_included { get; set; }
        public Nullable<byte> timemaster_sw { get; set; }
        public Nullable<int> waveform_size { get; set; }
        public Nullable<byte> print_enabled_sw { get; set; }
        public Nullable<byte> auto_record_alarm_sw { get; set; }
        public Nullable<byte> collect_12_lead_sw { get; set; }
        public Nullable<byte> print_auto_record_sw { get; set; }
        public Nullable<bool> encryption_status { get; set; }
    }
}
