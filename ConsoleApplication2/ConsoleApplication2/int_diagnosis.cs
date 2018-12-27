namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_diagnosis
    {
        [Key]
        [Column(Order = 0)]
        public Guid encounter_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int diagnosis_type_cid { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int seq_no { get; set; }

        public int? diagnosis_cid { get; set; }

        public byte? inactive_sw { get; set; }

        public DateTime? diagnosis_dt { get; set; }

        public int? class_cid { get; set; }

        public byte? confidential_ind { get; set; }

        public DateTime? attestation_dt { get; set; }

        [StringLength(255)]
        public string dsc { get; set; }
    }
}
