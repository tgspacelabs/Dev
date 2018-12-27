namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_diagnosis_hcp_int
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
        public int diagnosis_seq_no { get; set; }

        public byte? inactive_sw { get; set; }

        public DateTime? diagnosis_dt { get; set; }

        [Key]
        [Column(Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int desc_key { get; set; }

        public Guid? hcp_id { get; set; }
    }
}
