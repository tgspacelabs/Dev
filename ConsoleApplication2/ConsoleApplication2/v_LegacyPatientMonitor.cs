namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_LegacyPatientMonitor
    {
        [Key]
        [Column(Order = 0)]
        public Guid PatientId { get; set; }

        public Guid? DeviceId { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid DeviceSessionsId { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid EncounterId { get; set; }

        public DateTime? SessionStartTimeUTC { get; set; }
    }
}
