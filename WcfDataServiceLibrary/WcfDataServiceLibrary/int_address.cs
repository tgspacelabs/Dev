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
    
    public partial class int_address
    {
        public System.Guid address_id { get; set; }
        public string addr_loc_cd { get; set; }
        public string addr_type_cd { get; set; }
        public int seq_no { get; set; }
        public Nullable<byte> active_sw { get; set; }
        public Nullable<System.Guid> orig_patient_id { get; set; }
        public string line1_dsc { get; set; }
        public string line2_dsc { get; set; }
        public string line3_dsc { get; set; }
        public string city_nm { get; set; }
        public Nullable<int> county_cid { get; set; }
        public string state_code { get; set; }
        public Nullable<int> country_cid { get; set; }
        public string zip_code { get; set; }
        public Nullable<System.DateTime> start_dt { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}
