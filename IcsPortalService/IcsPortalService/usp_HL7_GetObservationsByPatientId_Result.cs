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
    
    public partial class usp_HL7_GetObservationsByPatientId_Result
    {
        public int CodeId { get; set; }
        public string Code { get; set; }
        public string Descr { get; set; }
        public string Units { get; set; }
        public string ResultValue { get; set; }
        public string ValueTypeCd { get; set; }
        public Nullable<int> ResultStatus { get; set; }
        public Nullable<double> Probability { get; set; }
        public Nullable<int> ReferenceRange { get; set; }
        public string AbnormalNatureCd { get; set; }
        public string AbnormalCd { get; set; }
        public Nullable<System.DateTime> ResultTime { get; set; }
    }
}
