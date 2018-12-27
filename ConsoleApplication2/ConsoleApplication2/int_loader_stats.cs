namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_loader_stats
    {
        [Key]
        public DateTime stat_dt { get; set; }

        [StringLength(1000)]
        public string stat_tx { get; set; }
    }
}
