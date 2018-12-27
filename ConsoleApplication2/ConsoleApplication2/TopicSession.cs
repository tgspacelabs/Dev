namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class TopicSession
    {
        public Guid Id { get; set; }

        public Guid? TopicTypeId { get; set; }

        public Guid? TopicInstanceId { get; set; }

        public Guid? DeviceSessionId { get; set; }

        public Guid? PatientSessionId { get; set; }

        public DateTime? BeginTimeUTC { get; set; }

        public DateTime? EndTimeUTC { get; set; }
    }
}
