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
    
    public partial class HL7PatientLink
    {
        public int MessageNo { get; set; }
        public string PatientMrn { get; set; }
        public string PatientVisitNumber { get; set; }
        public Nullable<System.Guid> PatientId { get; set; }
        public System.DateTime CreateDate { get; set; }
    
        public virtual HL7InboundMessage HL7InboundMessage { get; set; }
    }
}