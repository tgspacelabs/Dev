namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_event_log
    {
        [Key]
        [Column(Order = 0)]
        public Guid event_id { get; set; }

        public Guid? patient_id { get; set; }

        [StringLength(30)]
        public string type { get; set; }

        public DateTime? event_dt { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int seq_num { get; set; }

        [StringLength(50)]
        public string client { get; set; }

        [StringLength(300)]
        public string description { get; set; }

        public int? status { get; set; }
    }
}
