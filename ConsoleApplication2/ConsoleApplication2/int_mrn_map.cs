namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_mrn_map
    {
        [Key]
        [Column(Order = 0)]
        public Guid organization_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(30)]
        public string mrn_xid { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        [Key]
        [Column(Order = 3)]
        [StringLength(1)]
        public string merge_cd { get; set; }

        public Guid? prior_patient_id { get; set; }

        [StringLength(30)]
        public string mrn_xid2 { get; set; }

        public byte? adt_adm_sw { get; set; }
    }
}
