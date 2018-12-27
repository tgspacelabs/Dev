namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_savedevent_vitals
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid event_id { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(80)]
        public string gds_code { get; set; }

        public DateTime? result_dt { get; set; }

        [StringLength(200)]
        public string result_value { get; set; }

        public virtual int_SavedEvent int_SavedEvent { get; set; }
    }
}
