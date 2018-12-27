namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_savedevent_calipers
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid event_id { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int channel_type { get; set; }

        [Key]
        [Column(Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int caliper_type { get; set; }

        [Required]
        [StringLength(50)]
        public string calipers_orientation { get; set; }

        [StringLength(200)]
        public string caliper_text { get; set; }

        public long caliper_start_ms { get; set; }

        public long caliper_end_ms { get; set; }

        public int caliper_top { get; set; }

        public int caliper_bottom { get; set; }

        public int? first_caliper_index { get; set; }

        public int? second_caliper_index { get; set; }

        public virtual int_SavedEvent int_SavedEvent { get; set; }
    }
}
