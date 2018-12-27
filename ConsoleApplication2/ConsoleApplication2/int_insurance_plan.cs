namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_insurance_plan
    {
        [Key]
        public Guid plan_id { get; set; }

        [StringLength(30)]
        public string plan_cd { get; set; }

        public int? plan_type_cid { get; set; }

        public Guid? ins_company_id { get; set; }

        public int? agreement_type_cid { get; set; }

        [StringLength(1)]
        public string notice_of_admit_sw { get; set; }

        [StringLength(20)]
        public string plan_xid { get; set; }

        public int? preadmit_cert_cid { get; set; }
    }
}
