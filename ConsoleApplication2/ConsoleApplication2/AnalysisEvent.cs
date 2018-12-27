namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class AnalysisEvent
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid user_id { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int type { get; set; }

        public int num_events { get; set; }

        public short sample_rate { get; set; }

        [Column(TypeName = "image")]
        public byte[] event_data { get; set; }

        public virtual AnalysisTime AnalysisTime { get; set; }
    }
}
