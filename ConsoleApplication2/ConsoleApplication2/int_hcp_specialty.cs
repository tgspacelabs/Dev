namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_hcp_specialty
    {
        [Key]
        [Column(Order = 0)]
        public Guid hcp_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int specialty_cid { get; set; }

        [StringLength(50)]
        public string govern_board { get; set; }

        [StringLength(20)]
        public string certification_code { get; set; }

        public DateTime? certification_dt { get; set; }
    }
}
