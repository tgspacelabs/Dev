namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_patient_list_link
    {
        [Key]
        [Column(Order = 0)]
        public Guid master_owner_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid transfer_owner_id { get; set; }

        public Guid? patient_id { get; set; }

        [Key]
        [Column(Order = 2)]
        public DateTime start_dt { get; set; }

        public DateTime? end_dt { get; set; }

        [Key]
        [Column(Order = 3)]
        [StringLength(1)]
        public string type_cd { get; set; }

        public byte? deleted { get; set; }
    }
}
