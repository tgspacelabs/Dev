namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_SavedEvent_Waveform
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid event_id { get; set; }

        public int wave_index { get; set; }

        public int waveform_category { get; set; }

        public int lead { get; set; }

        public int resolution { get; set; }

        public int height { get; set; }

        public int waveform_type { get; set; }

        public byte visible { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid channel_id { get; set; }

        public double scale { get; set; }

        public int scale_type { get; set; }

        public int scale_min { get; set; }

        public int scale_max { get; set; }

        public int scale_unit_type { get; set; }

        public int duration { get; set; }

        public int sample_rate { get; set; }

        public long sample_count { get; set; }

        public int num_Ypoints { get; set; }

        public int baseline { get; set; }

        public double Ypoints_per_unit { get; set; }

        [Column(TypeName = "image")]
        public byte[] waveform_data { get; set; }

        public int num_timelogs { get; set; }

        [Column(TypeName = "image")]
        public byte[] timelog_data { get; set; }

        [StringLength(50)]
        public string waveform_color { get; set; }

        public virtual int_SavedEvent int_SavedEvent { get; set; }
    }
}
