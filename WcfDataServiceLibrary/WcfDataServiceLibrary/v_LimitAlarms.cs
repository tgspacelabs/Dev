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
    
    public partial class v_LimitAlarms
    {
        public System.Guid AlarmId { get; set; }
        public Nullable<System.Guid> PatientId { get; set; }
        public string SettingViolated { get; set; }
        public string ViolatingValue { get; set; }
        public int AlarmTypeId { get; set; }
        public string AlarmType { get; set; }
        public int StatusValue { get; set; }
        public int PriorityWeightValue { get; set; }
        public System.DateTime StartDateTimeUTC { get; set; }
        public Nullable<System.DateTime> EndDateTimeUTC { get; set; }
        public System.Guid TopicSessionId { get; set; }
        public Nullable<System.Guid> DeviceSessionId { get; set; }
        public string ChannelCode { get; set; }
        public string StrLabel { get; set; }
        public System.DateTime AcquiredDateTimeUTC { get; set; }
        public int Leads { get; set; }
        public string StrMessage { get; set; }
        public string StrLimitFormat { get; set; }
        public string StrValueFormat { get; set; }
        public Nullable<byte> Removed { get; set; }
    }
}