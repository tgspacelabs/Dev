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
    
    public partial class usp_CEI_GetAlarmTextOnly_Result
    {
        public System.Guid alarm_id { get; set; }
        public System.DateTime start_dt { get; set; }
        public Nullable<byte> alarm_level { get; set; }
        public string annotation { get; set; }
        public string mrn_xid { get; set; }
        public string mrn_xid2 { get; set; }
        public string first_nm { get; set; }
        public string middle_nm { get; set; }
        public string last_nm { get; set; }
        public System.Guid person_id { get; set; }
        public string organization_cd { get; set; }
        public string node_id { get; set; }
        public string monitor_name { get; set; }
    }
}
