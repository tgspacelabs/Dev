namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_outbound_queue
    {
        [Key]
        [Column(Order = 0)]
        public Guid outbound_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(3)]
        public string msg_event { get; set; }

        [Key]
        [Column(Order = 2)]
        public DateTime queued_dt { get; set; }

        [Key]
        [Column(Order = 3)]
        [StringLength(1)]
        public string msg_status { get; set; }

        public DateTime? processed_dt { get; set; }

        [Key]
        [Column(Order = 4)]
        public Guid patient_id { get; set; }

        public Guid? order_id { get; set; }

        public DateTime? obs_start_dt { get; set; }

        public DateTime? obs_end_dt { get; set; }
    }
}
