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
    
    public partial class p_On_Monitor_Result
    {
        public System.Guid patient_id { get; set; }
        public string MRN { get; set; }
        public string MONITOR { get; set; }
        public string LAST_NAME { get; set; }
        public string FIRST_NAME { get; set; }
        public Nullable<int> INTERVAL { get; set; }
        public Nullable<System.DateTime> poll_start_dt { get; set; }
        public Nullable<System.DateTime> poll_end_dt { get; set; }
        public string monitor_status { get; set; }
        public string monitor_error { get; set; }
    }
}
