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
    
    public partial class int_diagnosis
    {
        public System.Guid encounter_id { get; set; }
        public int diagnosis_type_cid { get; set; }
        public int seq_no { get; set; }
        public Nullable<int> diagnosis_cid { get; set; }
        public Nullable<byte> inactive_sw { get; set; }
        public Nullable<System.DateTime> diagnosis_dt { get; set; }
        public Nullable<int> class_cid { get; set; }
        public Nullable<byte> confidential_ind { get; set; }
        public Nullable<System.DateTime> attestation_dt { get; set; }
        public string dsc { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}