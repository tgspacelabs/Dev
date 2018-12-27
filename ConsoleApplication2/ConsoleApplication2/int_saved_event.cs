namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_saved_event
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int event_id { get; set; }

        [Key]
        [Column(Order = 2)]
        public DateTime insert_dt { get; set; }

        [Key]
        [Column(Order = 3)]
        public Guid user_id { get; set; }

        [Key]
        [Column(Order = 4)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int orig_event_category { get; set; }

        [Key]
        [Column(Order = 5)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int orig_event_type { get; set; }

        [Key]
        [Column(Order = 6)]
        public DateTime start_dt { get; set; }

        [Key]
        [Column(Order = 7)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public long start_ft { get; set; }

        public long? center_ft { get; set; }

        [Key]
        [Column(Order = 8)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int duration { get; set; }

        [Key]
        [Column(Order = 9)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int value1 { get; set; }

        [Key]
        [Column(Order = 10)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int divisor1 { get; set; }

        public int? value2 { get; set; }

        public int? divisor2 { get; set; }

        [Key]
        [Column(Order = 11)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int print_format { get; set; }

        [StringLength(50)]
        public string title { get; set; }

        [StringLength(50)]
        public string type { get; set; }

        [Key]
        [Column(Order = 12)]
        public byte rate_calipers { get; set; }

        [Key]
        [Column(Order = 13)]
        public byte measure_calipers { get; set; }

        public long? caliper_start_ft { get; set; }

        public long? caliper_end_ft { get; set; }

        public int? caliper_top { get; set; }

        public int? caliper_bottom { get; set; }

        public int? caliper_top_wave_type { get; set; }

        public int? caliper_bottom_wave_type { get; set; }

        [Key]
        [Column(Order = 14)]
        public byte annotate_data { get; set; }

        [Key]
        [Column(Order = 15)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int num_waveforms { get; set; }
    }
}
