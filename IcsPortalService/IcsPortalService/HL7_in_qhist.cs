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
    
    public partial class HL7_in_qhist
    {
        public decimal msg_no { get; set; }
        public int rec_id { get; set; }
        public string msg_status { get; set; }
        public System.DateTime queued_dt { get; set; }
        public Nullable<System.DateTime> outb_analyzed_dt { get; set; }
        public string HL7_text_short { get; set; }
        public string HL7_text_long { get; set; }
        public Nullable<System.DateTime> processed_dt { get; set; }
        public Nullable<int> processed_dur { get; set; }
        public Nullable<int> thread_id { get; set; }
        public string who { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}
