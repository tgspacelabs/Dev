namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_misc_code
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int code_id { get; set; }

        public Guid? organization_id { get; set; }

        public Guid? sys_id { get; set; }

        [StringLength(4)]
        public string category_cd { get; set; }

        [StringLength(10)]
        public string method_cd { get; set; }

        [StringLength(80)]
        public string code { get; set; }

        public byte? verification_sw { get; set; }

        [StringLength(80)]
        public string int_keystone_cd { get; set; }

        [StringLength(100)]
        public string short_dsc { get; set; }

        [StringLength(1)]
        public string spc_pcs_code { get; set; }
    }
}
