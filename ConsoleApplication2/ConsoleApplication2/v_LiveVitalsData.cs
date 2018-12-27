namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_LiveVitalsData
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(25)]
        public string Name { get; set; }

        [StringLength(25)]
        public string ResultValue { get; set; }

        public Guid? TopicTypeId { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid TopicSessionId { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid PatientId { get; set; }

        public Guid? TopicInstanceId { get; set; }

        public string GdsCode { get; set; }

        [Key]
        [Column(Order = 3)]
        public DateTime DateTimeStampUTC { get; set; }

        public DateTime? DateTimeStamp { get; set; }

        public long? FileDateTimeStamp { get; set; }

        [Key]
        [Column(Order = 4)]
        public Guid FeedTypeId { get; set; }
    }
}
