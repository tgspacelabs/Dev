namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class hl7_in_qhist
    {
        [Key]
        [Column(Order = 0, TypeName = "numeric")]
        public decimal msg_no { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int rec_id { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(1)]
        public string msg_status { get; set; }

        [Key]
        [Column(Order = 3)]
        public DateTime queued_dt { get; set; }

        public DateTime? outb_analyzed_dt { get; set; }

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
