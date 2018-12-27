namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_procedure
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int encounter_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int procedure_cid { get; set; }

        [Key]
        [Column(Order = 2)]
        public bool seq_no { get; set; }

        [Key]
        [Column(Order = 3)]
        public DateTime procedure_dt { get; set; }

        [Key]
        [Column(Order = 4)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int procedure_function_cid { get; set; }

        [Key]
        [Column(Order = 5)]
        public bool procedure_minutes { get; set; }

        public int? anesthesia_cid { get; set; }

        public bool? anesthesia_minutes { get; set; }

        [Key]
        [Column(Order = 6)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int consent_cid { get; set; }

        public bool? procedure_priority { get; set; }

        [Key]
        [Column(Order = 7)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int assoc_diag_cid { get; set; }
    }
}
