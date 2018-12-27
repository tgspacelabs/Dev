namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class hl7_in_queue
    {
        [Key]
        [Column(Order = 0, TypeName = "numeric")]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public decimal msg_no { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(1)]
        public string msg_status { get; set; }

        [Key]
        [Column(Order = 2)]
        public DateTime queued_dt { get; set; }

        public DateTime? outb_analyzed_dt { get; set; }

        [Key]
        [Column(Order = 3)]
        [StringLength(3)]
        public string msh_msg_type { get; set; }

        [Key]
        [Column(Order = 4)]
        [StringLength(3)]
        public string msh_event_cd { get; set; }

        [Key]
        [Column(Order = 5)]
        [StringLength(36)]
        public string msh_organization { get; set; }

        [Key]
        [Column(Order = 6)]
        [StringLength(36)]
        public string msh_system { get; set; }

        [Key]
        [Column(Order = 7)]
        public DateTime msh_dt { get; set; }

        [Key]
        [Column(Order = 8)]
        [StringLength(36)]
        public string msh_control_id { get; set; }

        [StringLength(2)]
        public string msh_ack_cd { get; set; }

        [Key]
        [Column(Order = 9)]
        [StringLength(5)]
        public string msh_version { get; set; }

        [StringLength(20)]
        public string pid_mrn { get; set; }

        [StringLength(50)]
        public string pv1_visit_no { get; set; }

        [Column(TypeName = "numeric")]
        public decimal? patient_id { get; set; }

        [StringLength(255)]
        public string hl7_text_short { get; set; }

        [Column(TypeName = "ntext")]
        public string hl7_text_long { get; set; }

        public DateTime? processed_dt { get; set; }

        public int? processed_dur { get; set; }

        public int? thread_id { get; set; }

        [StringLength(20)]
        public string who { get; set; }
    }
}
