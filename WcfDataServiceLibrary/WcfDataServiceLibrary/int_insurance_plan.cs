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
    
    public partial class int_insurance_plan
    {
        public System.Guid plan_id { get; set; }
        public string plan_cd { get; set; }
        public Nullable<int> plan_type_cid { get; set; }
        public Nullable<System.Guid> ins_company_id { get; set; }
        public Nullable<int> agreement_type_cid { get; set; }
        public string notice_of_admit_sw { get; set; }
        public string plan_xid { get; set; }
        public Nullable<int> preadmit_cert_cid { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}