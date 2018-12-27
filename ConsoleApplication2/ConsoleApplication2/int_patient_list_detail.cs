namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_patient_list_detail
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_list_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid encounter_id { get; set; }

        [Key]
        [Column(Order = 3)]
        public byte deleted { get; set; }

        [StringLength(1)]
        public string new_results { get; set; }

        public DateTime? viewed_results_dt { get; set; }
    }
}
