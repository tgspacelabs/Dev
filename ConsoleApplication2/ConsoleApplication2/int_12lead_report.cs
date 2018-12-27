namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_12lead_report
    {
        [Key]
        [Column(Order = 0)]
        public Guid report_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        public Guid monitor_id { get; set; }

        public int report_number { get; set; }

        public DateTime report_dt { get; set; }

        public byte? export_sw { get; set; }

        [Column(TypeName = "image")]
        [Required]
        public byte[] report_data { get; set; }

        public virtual int_12lead_report_new int_12lead_report_new { get; set; }
    }
}
