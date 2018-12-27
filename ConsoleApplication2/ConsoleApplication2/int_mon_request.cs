namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_mon_request
    {
        [Key]
        [Column(Order = 0)]
        public int req_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid monitor_id { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(10)]
        public string req_type { get; set; }

        [StringLength(100)]
        public string req_args { get; set; }

        [StringLength(2)]
        public string status { get; set; }

        [Key]
        [Column(Order = 3)]
        public DateTime mod_utc_dt { get; set; }
    }
}
