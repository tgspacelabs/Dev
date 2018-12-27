namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_patient_list
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_list_id { get; set; }

        public Guid? owner_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(3)]
        public string type_cd { get; set; }

        [StringLength(30)]
        public string list_name { get; set; }

        public int? svc_cid { get; set; }
    }
}
