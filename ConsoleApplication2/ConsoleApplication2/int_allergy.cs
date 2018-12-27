namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_allergy
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int allergy_cid { get; set; }

        public Guid? orig_patient_id { get; set; }

        public int? allergy_type_cid { get; set; }

        public int? severity_cid { get; set; }

        [StringLength(255)]
        public string reaction { get; set; }

        public DateTime? identification_dt { get; set; }

        [StringLength(1)]
        public string active_sw { get; set; }
    }
}
