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
    
    public partial class int_allergy
    {
        public System.Guid patient_id { get; set; }
        public int allergy_cid { get; set; }
        public Nullable<System.Guid> orig_patient_id { get; set; }
        public Nullable<int> allergy_type_cid { get; set; }
        public Nullable<int> severity_cid { get; set; }
        public string reaction { get; set; }
        public Nullable<System.DateTime> identification_dt { get; set; }
        public string active_sw { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}