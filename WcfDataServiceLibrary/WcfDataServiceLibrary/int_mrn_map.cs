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
    
    public partial class int_mrn_map
    {
        public System.Guid organization_id { get; set; }
        public string mrn_xid { get; set; }
        public System.Guid patient_id { get; set; }
        public Nullable<System.Guid> orig_patient_id { get; set; }
        public string merge_cd { get; set; }
        public Nullable<System.Guid> prior_patient_id { get; set; }
        public string mrn_xid2 { get; set; }
        public Nullable<byte> adt_adm_sw { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}
