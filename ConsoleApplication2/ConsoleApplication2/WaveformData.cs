namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("WaveformData")]
    public partial class WaveformData
    {
        public Guid Id { get; set; }

        public int SampleCount { get; set; }

        [StringLength(50)]
        public string TypeName { get; set; }

        public Guid? TypeId { get; set; }

        [Required]
        public byte[] Samples { get; set; }

        public bool Compressed { get; set; }

        public Guid TopicSessionId { get; set; }

        public DateTime StartTimeUTC { get; set; }

        public DateTime EndTimeUTC { get; set; }

        [Key]
        public long Sequence { get; set; }
    }
}
