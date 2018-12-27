namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_result
    {
        public Guid result_id { get; set; }

        public Guid patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        public DateTime? obs_start_dt { get; set; }

        public Guid order_id { get; set; }

        public byte? is_history { get; set; }

        public byte? monitor_sw { get; set; }

        public int univ_svc_cid { get; set; }

        public int test_cid { get; set; }

        public int? history_seq { get; set; }

        [StringLength(20)]
        public string test_sub_id { get; set; }

        public short? order_line_seq_no { get; set; }

        public short? test_result_seq_no { get; set; }

        public DateTime? result_dt { get; set; }

        [StringLength(10)]
        public string value_type_cd { get; set; }

        public Guid? specimen_id { get; set; }

        public int? source_cid { get; set; }

        public int? status_cid { get; set; }

        public DateTime? last_normal_dt { get; set; }

        public double? probability { get; set; }

        public Guid? obs_id { get; set; }

        public Guid? prin_rslt_intpr_id { get; set; }

        public Guid? asst_rslt_intpr_id { get; set; }

        public Guid? tech_id { get; set; }

        public Guid? trnscrbr_id { get; set; }

        public int? result_units_cid { get; set; }

        public int? reference_range_id { get; set; }

        [StringLength(10)]
        public string abnormal_cd { get; set; }

        [StringLength(10)]
        public string abnormal_nature_cd { get; set; }

        public int? prov_svc_cid { get; set; }

        [StringLength(10)]
        public string nsurv_tfr_ind { get; set; }

        [StringLength(255)]
        public string result_value { get; set; }

        [Column(TypeName = "ntext")]
        public string result_text { get; set; }

        [Column(TypeName = "ntext")]
        public string result_comment { get; set; }

        public byte? has_history { get; set; }

        public DateTime? mod_dt { get; set; }

        public Guid? mod_user_id { get; set; }

        [Key]
        public long Sequence { get; set; }

        public long? result_ft { get; set; }
    }
}
