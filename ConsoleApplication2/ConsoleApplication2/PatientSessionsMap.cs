namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("PatientSessionsMap")]
    public partial class PatientSessionsMap
    {
        public Guid PatientSessionId { get; set; }

        [Key]
        [Column(Order = 0)]
        public Guid PatientId { get; set; }

        [Key]
        [Column(Order = 1)]
        public long Sequence { get; set; }
    }
}
