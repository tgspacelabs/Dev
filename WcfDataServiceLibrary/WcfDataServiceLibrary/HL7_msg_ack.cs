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
    
    public partial class HL7_msg_ack
    {
        public string msg_control_id { get; set; }
        public string msg_status { get; set; }
        public string clientIP { get; set; }
        public string ack_msg_control_id { get; set; }
        public string ack_system { get; set; }
        public string ack_organization { get; set; }
        public Nullable<System.DateTime> received_dt { get; set; }
        public string notes { get; set; }
        public Nullable<int> num_retries { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}
