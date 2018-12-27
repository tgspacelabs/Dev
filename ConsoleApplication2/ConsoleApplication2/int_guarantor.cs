namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_guarantor
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int seq_no { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(2)]
        public string type_cd { get; set; }

        [Key]
        [Column(Order = 3)]
        public byte active_sw { get; set; }

        public Guid? orig_patient_id { get; set; }

        public int? relationship_cid { get; set; }

        public Guid? encounter_id { get; set; }

        public Guid? ext_organization_id { get; set; }

        public Guid? guarantor_person_id { get; set; }

        public Guid? employer_id { get; set; }

        public Guid? spouse_id { get; set; }

        public Guid? contact_id { get; set; }
    }
}
