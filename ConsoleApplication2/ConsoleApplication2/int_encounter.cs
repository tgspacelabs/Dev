namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_encounter
    {
        [Key]
        public Guid encounter_id { get; set; }

        public Guid? organization_id { get; set; }

        public DateTime? mod_dt { get; set; }

        public Guid? patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        public Guid? account_id { get; set; }

        [StringLength(3)]
        public string status_cd { get; set; }

        public int? publicity_cid { get; set; }

        public int? diet_type_cid { get; set; }

        public int? patient_class_cid { get; set; }

        public int? protection_type_cid { get; set; }

        [StringLength(2)]
        public string vip_sw { get; set; }

        public int? isolation_type_cid { get; set; }

        public int? security_type_cid { get; set; }

        public int? patient_type_cid { get; set; }

        public Guid? admit_hcp_id { get; set; }

        public int? med_svc_cid { get; set; }

        public Guid? referring_hcp_id { get; set; }

        public Guid? unit_org_id { get; set; }

        public Guid? attend_hcp_id { get; set; }

        public Guid? primary_care_hcp_id { get; set; }

        public int? fall_risk_type_cid { get; set; }

        public DateTime? begin_dt { get; set; }

        public int? ambul_status_cid { get; set; }

        public DateTime? admit_dt { get; set; }

        [StringLength(1)]
        public string baby_cd { get; set; }

        [StringLength(80)]
        public string rm { get; set; }

        [StringLength(1)]
        public string recurring_cd { get; set; }

        [StringLength(80)]
        public string bed { get; set; }

        public DateTime? discharge_dt { get; set; }

        [StringLength(1)]
        public string newborn_sw { get; set; }

        public int? discharge_dispo_cid { get; set; }

        public byte? monitor_created { get; set; }

        [Column(TypeName = "ntext")]
        public string comment { get; set; }
    }
}
