namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_LegacyWaveform
    {
        [Key]
        [Column(Order = 0)]
        public Guid Id { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int SampleCount { get; set; }

        [StringLength(50)]
        public string TypeName { get; set; }

        public Guid? TypeId { get; set; }

        [Key]
        [Column(Order = 2)]
        public byte[] WaveformData { get; set; }

        public Guid? TopicTypeId { get; set; }

        [Key]
        [Column(Order = 3)]
        public Guid TopicSessionId { get; set; }

        public Guid? DeviceSessionId { get; set; }

        public DateTime? SessionBeginUTC { get; set; }

        [Key]
        [Column(Order = 4)]
        public DateTime TimeStampBeginUTC { get; set; }

        [Key]
        [Column(Order = 5)]
        public DateTime TimeStampEndUTC { get; set; }

        public long? FileTimeStampBeginUTC { get; set; }

        public long? FileTimeStampEndUTC { get; set; }

        [Key]
        [Column(Order = 6)]
        public string SampleRate { get; set; }

        [Key]
        [Column(Order = 7)]
        public Guid PatientId { get; set; }

        public Guid? TopicInstanceId { get; set; }

        [StringLength(7)]
        public string CompressMethod { get; set; }
    }
}
