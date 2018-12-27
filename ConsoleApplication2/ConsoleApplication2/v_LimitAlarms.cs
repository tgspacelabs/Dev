namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_LimitAlarms
    {
        [Key]
        [Column(Order = 0)]
        public Guid AlarmId { get; set; }

        public Guid? PatientId { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(25)]
        public string SettingViolated { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(25)]
        public string ViolatingValue { get; set; }

        [Key]
        [Column(Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int AlarmTypeId { get; set; }

        [Key]
        [Column(Order = 4)]
        [StringLength(50)]
        public string AlarmType { get; set; }

        [Key]
        [Column(Order = 5)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int StatusValue { get; set; }

        [Key]
        [Column(Order = 6)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int PriorityWeightValue { get; set; }

        [Key]
        [Column(Order = 7)]
        public DateTime StartDateTimeUTC { get; set; }

        public DateTime? EndDateTimeUTC { get; set; }

        [Key]
        [Column(Order = 8)]
        public Guid TopicSessionId { get; set; }

        public Guid? DeviceSessionId { get; set; }

        public string ChannelCode { get; set; }

        public string StrLabel { get; set; }

        [Key]
        [Column(Order = 9)]
        public DateTime AcquiredDateTimeUTC { get; set; }

        [Key]
        [Column(Order = 10)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Leads { get; set; }

        public string StrMessage { get; set; }

        public string StrLimitFormat { get; set; }

        public string StrValueFormat { get; set; }

        public byte? Removed { get; set; }
    }
}
