namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_nok
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
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int notify_seq_no { get; set; }

        [Key]
        [Column(Order = 3)]
        public byte active_flag { get; set; }

        public Guid? orig_patient_id { get; set; }

        [Key]
        [Column(Order = 4)]
        public Guid nok_person_id { get; set; }

        public Guid? contact_person_id { get; set; }

        public int? relationship_cid { get; set; }
    }
}
