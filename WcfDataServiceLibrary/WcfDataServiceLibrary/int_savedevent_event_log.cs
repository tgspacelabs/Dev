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
    
    public partial class int_savedevent_event_log
    {
        public System.Guid patient_id { get; set; }
        public Nullable<System.Guid> orig_patient_id { get; set; }
        public System.Guid event_id { get; set; }
        public Nullable<bool> primary_channel { get; set; }
        public int timetag_type { get; set; }
        public Nullable<int> lead_type { get; set; }
        public Nullable<int> monitor_event_type { get; set; }
        public Nullable<int> arrhythmia_event_type { get; set; }
        public long start_ms { get; set; }
        public Nullable<long> end_ms { get; set; }
        public long int_savedevent_event_logID { get; set; }
        public System.DateTime CreateDate { get; set; }
    
        public virtual int_SavedEvent int_SavedEvent { get; set; }
    }
}