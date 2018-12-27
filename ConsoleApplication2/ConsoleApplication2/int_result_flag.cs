namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_result_flag
    {
        [Key]
        [Column(Order = 0)]
        public Guid flag_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(10)]
        public string flag { get; set; }

        [StringLength(10)]
        public string display_front { get; set; }

        [StringLength(10)]
        public string display_back { get; set; }

        public int? bitmap_ndx_front { get; set; }

        public int? bitmap_ndx_back { get; set; }

        [StringLength(20)]
        public string color_foreground { get; set; }

        [StringLength(20)]
        public string color_background { get; set; }

        public Guid? sys_id { get; set; }

        [StringLength(30)]
        public string comment { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int legend_rank { get; set; }

        public int? severity_rank { get; set; }
    }
}
