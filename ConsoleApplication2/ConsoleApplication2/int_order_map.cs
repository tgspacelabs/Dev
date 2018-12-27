namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_order_map
    {
        [Key]
        [Column(Order = 0)]
        public Guid order_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid organization_id { get; set; }

        [Key]
        [Column(Order = 3)]
        public Guid sys_id { get; set; }

        [Key]
        [Column(Order = 4)]
        [StringLength(30)]
        public string order_xid { get; set; }

        [StringLength(1)]
        public string type_cd { get; set; }

        [Key]
        [Column(Order = 5)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int seq_no { get; set; }
    }
}
