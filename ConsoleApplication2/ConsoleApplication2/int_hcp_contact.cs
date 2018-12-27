namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_hcp_contact
    {
        [Key]
        [Column(Order = 0)]
        public Guid hcp_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int contact_type_cid { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short seq_no { get; set; }

        [Key]
        [Column(Order = 3)]
        [StringLength(40)]
        public string hcp_contact_no { get; set; }

        [Key]
        [Column(Order = 4)]
        [StringLength(12)]
        public string hcp_contact_ext { get; set; }
    }
}
