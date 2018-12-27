namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("WaveformLiveData")]
    public partial class WaveformLiveData
    {
        [Key]
        public long Sequence { get; set; }

        public Guid Id { get; set; }

        public int SampleCount { get; set; }

        [StringLength(50)]
        public string TypeName { get; set; }

        public Guid? TypeId { get; set; }

        [Required]
        public byte[] Samples { get; set; }

        public Guid TopicInstanceId { get; set; }

        public DateTime StartTimeUTC { get; set; }

        public DateTime EndTimeUTC { get; set; }

        public int Mod4 { get; set; }
    }
}
