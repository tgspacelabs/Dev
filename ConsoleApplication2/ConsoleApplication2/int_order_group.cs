namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_order_group
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int node_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int rank { get; set; }

        public int? parent_node_id { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(80)]
        public string node_name { get; set; }

        public byte? display_in_menu { get; set; }
    }
}
