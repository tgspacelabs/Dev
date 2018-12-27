namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_hcp_map
    {
        [Key]
        [Column(Order = 0)]
        public Guid organization_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(20)]
        public string hcp_xid { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid hcp_id { get; set; }
    }
}
