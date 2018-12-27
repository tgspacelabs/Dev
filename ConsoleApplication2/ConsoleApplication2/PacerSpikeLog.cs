namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("PacerSpikeLog")]
    public partial class PacerSpikeLog
    {
        [Key]
        [Column(Order = 0)]
        public Guid user_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid patient_id { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short sample_rate { get; set; }

        public long start_ft { get; set; }

        public int num_spikes { get; set; }

        [Column(TypeName = "image")]
        [Required]
        public byte[] spike_data { get; set; }

        public virtual AnalysisTime AnalysisTime { get; set; }
    }
}
