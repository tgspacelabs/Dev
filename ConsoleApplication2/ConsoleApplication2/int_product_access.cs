namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_product_access
    {
        [Key]
        [StringLength(25)]
        public string product_cd { get; set; }

        public Guid? organization_id { get; set; }

        [StringLength(120)]
        public string license_no { get; set; }
    }
}
