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
    
    public partial class int_encounter_tfr_history
    {
        public string encounter_xid { get; set; }
        public System.Guid organization_id { get; set; }
        public System.Guid encounter_id { get; set; }
        public System.Guid patient_id { get; set; }
        public Nullable<System.Guid> orig_patient_id { get; set; }
        public Nullable<System.DateTime> tfr_txn_dt { get; set; }
        public Nullable<System.Guid> tfrd_from_encounter_id { get; set; }
        public Nullable<System.Guid> tfrd_to_encounter_id { get; set; }
        public Nullable<System.Guid> tfrd_from_patient_id { get; set; }
        public Nullable<System.Guid> tfrd_to_patient_id { get; set; }
        public string status_cd { get; set; }
        public string event_cd { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}
