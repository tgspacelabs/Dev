namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_order_line
    {
        [Key]
        [Column(Order = 0)]
        public Guid order_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short seq_no { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        public int? status_cid { get; set; }

        public int? prov_svc_cid { get; set; }

        public int? univ_svc_cid { get; set; }

        public int? transport_cid { get; set; }

        [Column(TypeName = "ntext")]
        public string order_line_comment { get; set; }

        [Column(TypeName = "ntext")]
        public string clin_info_comment { get; set; }

        [Column(TypeName = "ntext")]
        public string reason_comment { get; set; }

        public DateTime? scheduled_dt { get; set; }

        public DateTime? observ_dt { get; set; }

        public DateTime? status_chg_dt { get; set; }
    }
}
