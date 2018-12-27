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
    
    public partial class v_LegacyWaveform
    {
        public System.Guid Id { get; set; }
        public int SampleCount { get; set; }
        public string TypeName { get; set; }
        public Nullable<System.Guid> TypeId { get; set; }
        public byte[] WaveformData { get; set; }
        public Nullable<System.Guid> TopicTypeId { get; set; }
        public System.Guid TopicSessionId { get; set; }
        public Nullable<System.Guid> DeviceSessionId { get; set; }
        public Nullable<System.DateTime> SessionBeginUTC { get; set; }
        public System.DateTime TimeStampBeginUTC { get; set; }
        public System.DateTime TimeStampEndUTC { get; set; }
        public Nullable<long> FileTimeStampBeginUTC { get; set; }
        public Nullable<long> FileTimeStampEndUTC { get; set; }
        public string SampleRate { get; set; }
        public System.Guid PatientId { get; set; }
        public Nullable<System.Guid> TopicInstanceId { get; set; }
        public string CompressMethod { get; set; }
    }
}
