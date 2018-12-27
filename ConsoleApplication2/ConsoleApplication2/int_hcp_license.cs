namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_hcp_license
    {
        [Key]
        [Column(Order = 0)]
        public Guid hcp_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int license_type_cid { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(3)]
        public string license_state_code { get; set; }

        [StringLength(10)]
        public string license_xid { get; set; }

        public DateTime? effective_dt { get; set; }

        public DateTime? expiration_dt { get; set; }
    }
}
