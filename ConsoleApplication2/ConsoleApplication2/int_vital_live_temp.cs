namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_vital_live_temp
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid monitor_id { get; set; }

        [Key]
        [Column(Order = 2)]
        public DateTime collect_dt { get; set; }

        [Key]
        [Column(Order = 3)]
        [StringLength(4000)]
        public string vital_value { get; set; }

        [StringLength(3950)]
        public string vital_time { get; set; }

        public DateTime? createdDT { get; set; }
    }
}
