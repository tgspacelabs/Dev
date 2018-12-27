namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_alarm_retrieved
    {
        [Key]
        [Column(Order = 0)]
        public Guid alarm_id { get; set; }

        [StringLength(120)]
        public string annotation { get; set; }

        public byte? retrieved { get; set; }

        [Key]
        [Column(Order = 1)]
        public DateTime insert_dt { get; set; }
    }
}
