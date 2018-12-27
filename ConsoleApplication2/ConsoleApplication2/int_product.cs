namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_product
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(25)]
        public string product_cd { get; set; }

        [StringLength(120)]
        public string descr { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short has_access { get; set; }
    }
}
