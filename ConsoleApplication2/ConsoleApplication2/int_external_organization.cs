namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_external_organization
    {
        [Key]
        public Guid ext_organization_id { get; set; }

        [StringLength(1)]
        public string cat_code { get; set; }

        [StringLength(50)]
        public string organization_nm { get; set; }

        public Guid? parent_ext_organization_id { get; set; }

        [StringLength(30)]
        public string organization_cd { get; set; }

        [StringLength(50)]
        public string company_cons { get; set; }
    }
}
