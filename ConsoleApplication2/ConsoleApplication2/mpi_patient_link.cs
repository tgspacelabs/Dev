namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class mpi_patient_link
    {
        [Key]
        [Column(Order = 0)]
        public Guid orig_patient_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid new_patient_id { get; set; }

        public Guid? user_id { get; set; }

        [Key]
        [Column(Order = 2)]
        public DateTime mod_dt { get; set; }
    }
}
