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
    
    public partial class AnalysisEvent
    {
        public System.Guid patient_id { get; set; }
        public System.Guid user_id { get; set; }
        public int type { get; set; }
        public int num_events { get; set; }
        public short sample_rate { get; set; }
        public byte[] event_data { get; set; }
        public System.DateTime CreateDate { get; set; }
    
        public virtual AnalysisTime AnalysisTime { get; set; }
    }
}