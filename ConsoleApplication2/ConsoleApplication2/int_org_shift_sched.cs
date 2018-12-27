namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_org_shift_sched
    {
        [Key]
        [Column(Order = 0)]
        public Guid organization_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(8)]
        public string shift_nm { get; set; }

        public DateTime? shift_start_tm { get; set; }
    }
}
