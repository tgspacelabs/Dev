namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_sysgen_audit
    {
        [Key]
        [Column(Order = 0)]
        public DateTime audit_dt { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(255)]
        public string audit { get; set; }
    }
}
