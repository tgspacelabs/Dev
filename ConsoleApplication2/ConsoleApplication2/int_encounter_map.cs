namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_encounter_map
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(40)]
        public string encounter_xid { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid organization_id { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid encounter_id { get; set; }

        [Key]
        [Column(Order = 3)]
        public Guid patient_id { get; set; }

        [Key]
        [Column(Order = 4)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int seq_no { get; set; }

        public Guid? orig_patient_id { get; set; }

        [StringLength(1)]
        public string status_cd { get; set; }

        [StringLength(4)]
        public string event_cd { get; set; }

        public Guid? account_id { get; set; }
    }
}
