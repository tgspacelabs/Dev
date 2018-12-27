namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_hcp
    {
        [Key]
        public Guid hcp_id { get; set; }

        public int? hcp_type_cid { get; set; }

        [StringLength(50)]
        public string last_nm { get; set; }

        [StringLength(50)]
        public string first_nm { get; set; }

        [StringLength(50)]
        public string middle_nm { get; set; }

        [StringLength(20)]
        public string degree { get; set; }

        public byte? verification_sw { get; set; }

        [StringLength(10)]
        public string doctor_ins_no_id { get; set; }

        [StringLength(10)]
        public string doctor_dea_no { get; set; }

        [StringLength(12)]
        public string medicare_id { get; set; }

        [StringLength(20)]
        public string medicaid_id { get; set; }
    }
}
