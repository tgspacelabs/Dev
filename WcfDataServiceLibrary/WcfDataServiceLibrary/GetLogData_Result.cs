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
    
    public partial class GetLogData_Result
    {
        public System.Guid LogId { get; set; }
        public System.DateTime DateTime { get; set; }
        public string PatientID { get; set; }
        public string Application { get; set; }
        public string DeviceName { get; set; }
        public string Message { get; set; }
        public string LocalizedMessage { get; set; }
        public Nullable<int> MessageId { get; set; }
        public string LogType { get; set; }
        public long Sequence { get; set; }
    }
}