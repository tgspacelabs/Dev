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
    
    public partial class RetrieveBeatTimeLogWithSampleRate_Result
    {
        public System.Guid user_id { get; set; }
        public System.Guid patient_id { get; set; }
        public long start_ft { get; set; }
        public int num_beats { get; set; }
        public short sample_rate { get; set; }
        public byte[] beat_data { get; set; }
    }
}
