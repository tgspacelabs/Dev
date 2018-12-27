namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_diagnosis_drg
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid encounter_id { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid account_id { get; set; }

        [Key]
        [Column(Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int desc_key { get; set; }

        public Guid? orig_patient_id { get; set; }

        public int? drg_cid { get; set; }

        public DateTime? drg_assignment_dt { get; set; }

        [StringLength(2)]
        public string drg_approval_ind { get; set; }

        public int? drg_grper_rvw_cid { get; set; }

        public int? drg_outlier_cid { get; set; }

        public int? drg_outlier_days_no { get; set; }

        [Column(TypeName = "smallmoney")]
        public decimal? drg_outlier_cost_amt { get; set; }

        public int? drg_grper_ver_type_cid { get; set; }
    }
}
