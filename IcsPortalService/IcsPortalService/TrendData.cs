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
    
    public partial class TrendData
    {
        public System.Guid user_id { get; set; }
        public System.Guid patient_id { get; set; }
        public int total_categories { get; set; }
        public long start_ft { get; set; }
        public int total_periods { get; set; }
        public int samples_per_period { get; set; }
        public byte[] trend_data { get; set; }
        public System.DateTime CreateDate { get; set; }
    
        public virtual AnalysisTime AnalysisTime { get; set; }
    }
}
