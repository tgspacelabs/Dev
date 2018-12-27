namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_client_map
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(20)]
        public string map_type { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(40)]
        public string map_val { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(50)]
        public string unit_nm { get; set; }
    }
}
