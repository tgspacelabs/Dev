namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class mpi_decision_log
    {
        [Key]
        [Column(Order = 0)]
        public Guid candidate_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid matched_id { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int score { get; set; }

        [Key]
        [Column(Order = 3)]
        public DateTime mod_dt { get; set; }

        [StringLength(3)]
        public string status_code { get; set; }
    }
}
