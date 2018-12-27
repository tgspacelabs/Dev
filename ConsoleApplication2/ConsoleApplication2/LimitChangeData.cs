namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("LimitChangeData")]
    public partial class LimitChangeData
    {
        public Guid Id { get; set; }

        [StringLength(25)]
        public string High { get; set; }

        [StringLength(25)]
        public string Low { get; set; }

        [StringLength(25)]
        public string ExtremeHigh { get; set; }

        [StringLength(25)]
        public string ExtremeLow { get; set; }

        [StringLength(25)]
        public string Desat { get; set; }

        public DateTime AcquiredDateTimeUTC { get; set; }

        public Guid TopicSessionId { get; set; }

        public Guid FeedTypeId { get; set; }

        public Guid EnumGroupId { get; set; }

        public int IDEnumValue { get; set; }
    }
}
