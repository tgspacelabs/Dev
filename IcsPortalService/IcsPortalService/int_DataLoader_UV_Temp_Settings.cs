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
    
    public partial class int_DataLoader_UV_Temp_Settings
    {
        public System.Guid gateway_id { get; set; }
        public string gateway_type { get; set; }
        public string network_name { get; set; }
        public string network_id { get; set; }
        public string node_name { get; set; }
        public string node_id { get; set; }
        public Nullable<System.Guid> uv_organization_id { get; set; }
        public Nullable<System.Guid> uv_unit_id { get; set; }
        public string include_nodes { get; set; }
        public string exclude_nodes { get; set; }
        public Nullable<byte> uv_do_not_store_waveforms { get; set; }
        public Nullable<byte> print_requests { get; set; }
        public Nullable<byte> make_time_master { get; set; }
        public Nullable<byte> auto_assign_id { get; set; }
        public string new_mrn_format { get; set; }
        public Nullable<byte> uv_print_alarms { get; set; }
        public Nullable<int> debug_level { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}
