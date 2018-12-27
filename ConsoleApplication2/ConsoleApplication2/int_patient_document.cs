namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_patient_document
    {
        public Guid? patient_id { get; set; }

        public int? seq_no { get; set; }

        public Guid? orig_patient_id { get; set; }

        [StringLength(80)]
        public string document_id { get; set; }

        public int? node_id { get; set; }

        public DateTime? document_dt { get; set; }

        [Key]
        [StringLength(80)]
        public string document_desc { get; set; }
    }
}
