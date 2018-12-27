namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_autoupdate_log
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(50)]
        public string machine { get; set; }

        [Key]
        [Column(Order = 1)]
        public DateTime action_dt { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(3)]
        public string prod { get; set; }

        [Key]
        [Column(Order = 3)]
        public byte success { get; set; }

        [StringLength(80)]
        public string reason { get; set; }
    }
}
