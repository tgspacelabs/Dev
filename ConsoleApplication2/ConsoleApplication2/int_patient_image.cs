namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_patient_image
    {
        public Guid? patient_id { get; set; }

        public Guid? order_id { get; set; }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short seq_no { get; set; }

        public Guid? orig_patient_id { get; set; }

        public int? image_type_cid { get; set; }

        [StringLength(255)]
        public string image_path { get; set; }

        [Column(TypeName = "image")]
        public byte[] image { get; set; }
    }
}
