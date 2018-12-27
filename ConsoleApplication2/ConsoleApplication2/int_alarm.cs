namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_alarm
    {
        [Key]
        [Column(Order = 0)]
        public Guid alarm_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid patient_channel_id { get; set; }

        public DateTime start_dt { get; set; }

        public DateTime? end_dt { get; set; }

        public long? start_ft { get; set; }

        public long? end_ft { get; set; }

        [StringLength(50)]
        public string alarm_cd { get; set; }

        [StringLength(255)]
        public string alarm_dsc { get; set; }

        public byte? removed { get; set; }

        public byte? alarm_level { get; set; }

        [StringLength(1)]
        public string is_stacked { get; set; }

        [StringLength(1)]
        public string is_level_changed { get; set; }
    }
}
