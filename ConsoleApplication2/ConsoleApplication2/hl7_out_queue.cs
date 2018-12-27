namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class hl7_out_queue
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(10)]
        public string msg_status { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(20)]
        public string msg_no { get; set; }

        [Column(TypeName = "ntext")]
        public string hl7_text_long { get; set; }

        [StringLength(255)]
        public string hl7_text_short { get; set; }

        [StringLength(60)]
        public string patient_id { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(50)]
        public string msh_system { get; set; }

        [Key]
        [Column(Order = 3)]
        [StringLength(50)]
        public string msh_organization { get; set; }

        [Key]
        [Column(Order = 4)]
        [StringLength(10)]
        public string msh_event_cd { get; set; }

        [Key]
        [Column(Order = 5)]
        [StringLength(10)]
        public string msh_msg_type { get; set; }

        public DateTime? sent_dt { get; set; }

        [Key]
        [Column(Order = 6)]
        public DateTime queued_dt { get; set; }
    }
}
