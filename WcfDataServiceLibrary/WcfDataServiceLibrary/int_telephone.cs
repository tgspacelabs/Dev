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
    
    public partial class int_telephone
    {
        public System.Guid phone_id { get; set; }
        public string phone_loc_cd { get; set; }
        public string phone_type_cd { get; set; }
        public int seq_no { get; set; }
        public Nullable<System.Guid> orig_patient_id { get; set; }
        public byte active_sw { get; set; }
        public string tel_no { get; set; }
        public string ext_no { get; set; }
        public string areacode { get; set; }
        public Nullable<short> mpi_tel1 { get; set; }
        public Nullable<short> mpi_tel2 { get; set; }
        public Nullable<short> mpi_tel3 { get; set; }
        public Nullable<System.DateTime> start_dt { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}
