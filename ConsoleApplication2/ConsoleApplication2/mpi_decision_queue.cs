namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class mpi_decision_queue
    {
        [Key]
        [Column(Order = 0)]
        public Guid candidate_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public DateTime mod_dt { get; set; }

        public DateTime? processed_dt { get; set; }
    }
}
