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
    
    public partial class int_waveform_live
    {
        public System.Guid patient_id { get; set; }
        public Nullable<System.Guid> orig_patient_id { get; set; }
        public System.Guid patient_channel_id { get; set; }
        public System.DateTime start_dt { get; set; }
        public Nullable<System.DateTime> end_dt { get; set; }
        public Nullable<long> start_ft { get; set; }
        public Nullable<long> end_ft { get; set; }
        public string compress_method { get; set; }
        public byte[] waveform_data { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}
