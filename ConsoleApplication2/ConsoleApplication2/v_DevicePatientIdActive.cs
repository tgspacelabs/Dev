namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_DevicePatientIdActive
    {
        public Guid? DeviceId { get; set; }

        [Key]
        [Column(Order = 0)]
        [StringLength(30)]
        public string ID1 { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid PatientId { get; set; }
    }
}
