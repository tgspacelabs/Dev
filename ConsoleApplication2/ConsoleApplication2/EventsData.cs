namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("EventsData")]
    public partial class EventsData
    {
        public Guid Id { get; set; }

        public int CategoryValue { get; set; }

        public int Type { get; set; }

        public int Subtype { get; set; }

        public float Value1 { get; set; }

        public float Value2 { get; set; }

        public int status { get; set; }

        public int valid_leads { get; set; }

        public Guid TopicSessionId { get; set; }

        public Guid FeedTypeId { get; set; }

        public DateTime TimeStampUTC { get; set; }

        [Key]
        public long Sequence { get; set; }
    }
}
