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
    
    public partial class int_event_config
    {
        public int alarm_notification_mode { get; set; }
        public int vitals_update_interval { get; set; }
        public int alarm_polling_interval { get; set; }
        public int port_number { get; set; }
        public Nullable<byte> track_alarm_execution { get; set; }
        public Nullable<byte> track_vitals_update_execution { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}