namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class cdr_navigation_button
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(80)]
        public string descr { get; set; }

        public int? image_index { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int position { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(255)]
        public string form_name { get; set; }

        public int? node_id { get; set; }

        [StringLength(1)]
        public string shortcut { get; set; }
    }
}
