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
    
    public partial class int_monitor
    {
        public System.Guid monitor_id { get; set; }
        public Nullable<System.Guid> unit_org_id { get; set; }
        public string network_id { get; set; }
        public string node_id { get; set; }
        public string bed_id { get; set; }
        public string bed_cd { get; set; }
        public string room { get; set; }
        public string monitor_dsc { get; set; }
        public string monitor_name { get; set; }
        public string monitor_type_cd { get; set; }
        public string subnet { get; set; }
        public Nullable<byte> standby { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}
