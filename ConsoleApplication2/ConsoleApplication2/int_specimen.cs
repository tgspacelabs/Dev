namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_specimen
    {
        [Key]
        [Column(Order = 0)]
        public Guid specimen_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid order_id { get; set; }

        public Guid? patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        public int? univ_svc_cid { get; set; }

        public int? status_cid { get; set; }

        public Guid? encounter_id { get; set; }

        public Guid? collect_id { get; set; }

        [StringLength(15)]
        public string specimen_xid { get; set; }

        public DateTime? procedure_dt { get; set; }

        public int? source_cid { get; set; }

        public int? body_site_cid { get; set; }

        public Guid? comment_id { get; set; }

        public DateTime? collect_dt { get; set; }

        public short? collect_vol_qty { get; set; }

        [StringLength(10)]
        public string collect_vol_unit_code_id { get; set; }

        [StringLength(80)]
        public string collect_method { get; set; }

        [StringLength(30)]
        public string source_additive { get; set; }

        [StringLength(1)]
        public string action_code_id { get; set; }

        public int? call_back_phone_cat_id { get; set; }

        public int? fields_key { get; set; }

        public DateTime? receive_dt { get; set; }

        public int? handle_cid { get; set; }

        public int? handle_cat_cid { get; set; }
    }
}
