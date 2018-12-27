namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class ml_duplicate_info
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(20)]
        public string Original_ID { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(20)]
        public string Duplicate_Id { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(5)]
        public string Original_Monitor { get; set; }

        [Key]
        [Column(Order = 3)]
        [StringLength(5)]
        public string Duplicate_Monitor { get; set; }

        public DateTime InsertDT { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long duplicate_rec_id { get; set; }
    }
}
