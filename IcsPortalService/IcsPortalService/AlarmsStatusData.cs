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
    
    public partial class AlarmsStatusData
    {
        public System.Guid Id { get; set; }
        public System.Guid AlarmId { get; set; }
        public Nullable<byte> StatusTimeout { get; set; }
        public int StatusValue { get; set; }
        public System.DateTime AcquiredDateTimeUTC { get; set; }
        public int Leads { get; set; }
        public System.Guid WaveformFeedTypeId { get; set; }
        public System.Guid TopicSessionId { get; set; }
        public System.Guid FeedTypeId { get; set; }
        public int IDEnumValue { get; set; }
        public System.Guid EnumGroupId { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}
