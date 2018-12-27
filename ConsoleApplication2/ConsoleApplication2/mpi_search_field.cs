namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class mpi_search_field
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(30)]
        public string field_name { get; set; }

        [StringLength(30)]
        public string col_name { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short low { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short high { get; set; }

        [StringLength(30)]
        public string compare_type { get; set; }

        [StringLength(4)]
        public string code_category { get; set; }

        public int? is_secondary { get; set; }

        public int? is_primary { get; set; }

        [StringLength(100)]
        public string hl7_field { get; set; }
    }
}
