namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("GeneralAlarmsData")]
    public partial class GeneralAlarmsData
    {
        public Guid AlarmId { get; set; }

        public byte? StatusTimeout { get; set; }

        [Key]
        [Column(Order = 0)]
        public DateTime StartDateTime { get; set; }

        public DateTime? EndDateTime { get; set; }

        public int StatusValue { get; set; }

        public int PriorityWeightValue { get; set; }

        public DateTime AcquiredDateTimeUTC { get; set; }

        public int Leads { get; set; }

        public Guid WaveformFeedTypeId { get; set; }

        public Guid TopicSessionId { get; set; }

        public Guid FeedTypeId { get; set; }

        public int IDEnumValue { get; set; }

        public Guid EnumGroupId { get; set; }

        [Key]
        [Column(Order = 1)]
        public long Sequence { get; set; }
    }
}
