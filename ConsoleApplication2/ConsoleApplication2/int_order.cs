namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_order
    {
        [Key]
        [Column(Order = 0)]
        public Guid encounter_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid order_id { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        public int? priority_cid { get; set; }

        public int? status_cid { get; set; }

        public int? univ_svc_cid { get; set; }

        public Guid? order_person_id { get; set; }

        public DateTime? order_dt { get; set; }

        public Guid? enter_id { get; set; }

        public Guid? verif_id { get; set; }

        public Guid? transcriber_id { get; set; }

        public Guid? parent_order_id { get; set; }

        public byte? child_order_sw { get; set; }

        public int? order_cntl_cid { get; set; }

        public byte? history_sw { get; set; }

        public byte? monitor_sw { get; set; }
    }
}
