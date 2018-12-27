namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_nxt_descending_key
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(30)]
        public string tbl_name { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int descend_key { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(255)]
        public string filler1 { get; set; }

        [Key]
        [Column(Order = 3)]
        [StringLength(255)]
        public string filler2 { get; set; }

        [Key]
        [Column(Order = 4)]
        [StringLength(255)]
        public string filler3 { get; set; }

        [Key]
        [Column(Order = 5)]
        [StringLength(255)]
        public string filler4 { get; set; }

        [Key]
        [Column(Order = 6)]
        [StringLength(255)]
        public string filler5 { get; set; }

        [Key]
        [Column(Order = 7)]
        [StringLength(255)]
        public string filler6 { get; set; }

        [Key]
        [Column(Order = 8)]
        [StringLength(255)]
        public string filler7 { get; set; }

        [Key]
        [Column(Order = 9)]
        [StringLength(139)]
        public string filler8 { get; set; }
    }
}
