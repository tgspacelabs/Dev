namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_GeneralAlarms
    {
        [Key]
        [Column(Order = 0)]
        public Guid AlarmId { get; set; }

        public Guid? PatientId { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int AlarmTypeId { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(50)]
        public string AlarmType { get; set; }

        [Key]
        [Column(Order = 3)]
        [StringLength(50)]
        public string Title { get; set; }

        [Key]
        [Column(Order = 4)]
        public Guid EnumGroupId { get; set; }

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

        public Guid? TopicSessionId { get; set; }

        public Guid? DeviceSessionId { get; set; }

        public string ChannelCode { get; set; }

        public string StrLabel { get; set; }

        [Key]
        [Column(Order = 8)]
        public DateTime AcquiredDateTimeUTC { get; set; }

        [Key]
        [Column(Order = 9)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Leads { get; set; }

        public string StrMessage { get; set; }

        public byte? Removed { get; set; }
    }
}
