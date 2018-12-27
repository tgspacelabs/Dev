namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class hl7_msg_ack
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(20)]
        public string msg_control_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(10)]
        public string msg_status { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(30)]
        public string clientIP { get; set; }

        [StringLength(20)]
        public string ack_msg_control_id { get; set; }

        [StringLength(50)]
        public string ack_system { get; set; }

        [StringLength(50)]
        public string ack_organization { get; set; }

        public DateTime? received_dt { get; set; }

        [StringLength(80)]
        public string notes { get; set; }

        public int? num_retries { get; set; }
    }
}
