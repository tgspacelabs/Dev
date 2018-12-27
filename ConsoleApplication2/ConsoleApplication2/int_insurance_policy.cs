namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_insurance_policy
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short seq_no { get; set; }

        public byte? active_sw { get; set; }

        public Guid? orig_patient_id { get; set; }

        public Guid? account_id { get; set; }

        [StringLength(20)]
        public string ins_policy_xid { get; set; }

        public Guid? holder_id { get; set; }

        public int? holder_rel_cid { get; set; }

        public Guid? holder_emp_id { get; set; }

        public Guid? plan_id { get; set; }

        [StringLength(20)]
        public string group_xid { get; set; }

        [StringLength(35)]
        public string group_nm { get; set; }

        [StringLength(8)]
        public string company_plan_cid { get; set; }

        public DateTime? plan_eff_dt { get; set; }

        public DateTime? plan_exp_dt { get; set; }

        public DateTime? verify_dt { get; set; }

        [Column(TypeName = "money")]
        public decimal? plcy_deductible_amt { get; set; }

        [Column(TypeName = "money")]
        public decimal? plcy_limit_amt { get; set; }

        public short? plcy_limit_days_no { get; set; }

        [Column(TypeName = "money")]
        public decimal? rm_semi_private_rt { get; set; }

        [Column(TypeName = "money")]
        public decimal? rm_private_rt { get; set; }

        [StringLength(20)]
        public string authorization_no { get; set; }

        public DateTime? authorization_dt { get; set; }

        [StringLength(4)]
        public string authorization_source { get; set; }

        public Guid? authorization_cmt_id { get; set; }

        public byte? cob_priority { get; set; }

        [StringLength(2)]
        public string cob_code { get; set; }

        [StringLength(3)]
        public string billing_status_code { get; set; }

        public byte? rpt_of_eligibility_sw { get; set; }

        public DateTime? rpt_of_eligibility_dt { get; set; }

        [StringLength(2)]
        public string assignment_of_benefits_sw { get; set; }

        public DateTime? notice_of_admit_dt { get; set; }

        public Guid? verify_id { get; set; }

        public short? lifetm_reserve_days_no { get; set; }

        public short? delay_before_lr_day_no { get; set; }

        public Guid? ins_contact_id { get; set; }

        [StringLength(20)]
        public string plan_xid { get; set; }
    }
}
