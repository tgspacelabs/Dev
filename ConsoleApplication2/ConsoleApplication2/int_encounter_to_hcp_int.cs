namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_encounter_to_hcp_int
    {
        [Key]
        [Column(Order = 0)]
        public Guid encounter_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid hcp_id { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(1)]
        public string hcp_role_cd { get; set; }

        public DateTime? end_dt { get; set; }

        [Key]
        [Column(Order = 3)]
        public byte active_sw { get; set; }
    }
}
