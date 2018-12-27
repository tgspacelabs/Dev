namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_patient_monitor
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_monitor_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid monitor_id { get; set; }

        public int? monitor_interval { get; set; }

        [Key]
        [Column(Order = 3)]
        [StringLength(1)]
        public string poll_type { get; set; }

        public DateTime? monitor_connect_dt { get; set; }

        public int? monitor_connect_num { get; set; }

        public byte? disable_sw { get; set; }

        public DateTime? last_poll_dt { get; set; }

        public DateTime? last_result_dt { get; set; }

        public DateTime? last_episodic_dt { get; set; }

        public DateTime? poll_start_dt { get; set; }

        public DateTime? poll_end_dt { get; set; }

        public DateTime? last_outbound_dt { get; set; }

        [StringLength(3)]
        public string monitor_status { get; set; }

        [StringLength(255)]
        public string monitor_error { get; set; }

        public Guid? encounter_id { get; set; }

        public DateTime? live_until_dt { get; set; }

        public byte? active_sw { get; set; }
    }
}
