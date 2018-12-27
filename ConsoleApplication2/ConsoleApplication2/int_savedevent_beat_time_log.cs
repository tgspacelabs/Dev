namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_savedevent_beat_time_log
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid event_id { get; set; }

        public long patient_start_ft { get; set; }

        public long start_ft { get; set; }

        public int num_beats { get; set; }

        public short sample_rate { get; set; }

        [Column(TypeName = "image")]
        [Required]
        public byte[] beat_data { get; set; }

        public virtual int_SavedEvent int_SavedEvent { get; set; }
    }
}
