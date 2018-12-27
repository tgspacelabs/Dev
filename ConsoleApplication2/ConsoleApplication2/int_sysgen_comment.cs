namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_sysgen_comment
    {
        [Key]
        [Column(Order = 0)]
        public DateTime comment_dt { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(255)]
        public string comment { get; set; }
    }
}
