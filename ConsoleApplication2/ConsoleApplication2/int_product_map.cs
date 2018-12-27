namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_product_map
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(25)]
        public string product_cd { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(25)]
        public string feature_cd { get; set; }
    }
}
