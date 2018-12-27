namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class PatientSession
    {
        public Guid Id { get; set; }

        public DateTime BeginTimeUTC { get; set; }

        public DateTime? EndTimeUTC { get; set; }

        [Key]
        public long Sequence { get; set; }
    }
}
