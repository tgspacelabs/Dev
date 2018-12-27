namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_test_group_detail
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int node_id { get; set; }

        public int? test_cid { get; set; }

        public int? univ_svc_cid { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int rank { get; set; }

        [StringLength(5)]
        public string display_type { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(80)]
        public string nm { get; set; }

        public int? source_cid { get; set; }

        public int? alias_test_cid { get; set; }

        public int? alias_univ_svc_cid { get; set; }
    }
}
