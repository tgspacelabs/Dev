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
    
    public partial class VitalsData
    {
        public long ID { get; set; }
        public System.Guid SetId { get; set; }
        public string Name { get; set; }
        public string Value { get; set; }
        public System.Guid TopicSessionId { get; set; }
        public System.Guid FeedTypeId { get; set; }
        public System.DateTime TimestampUTC { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}
