namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_DeviceSessionAssignment
    {
        [Key]
        public Guid DeviceSessionId { get; set; }

        [StringLength(100)]
        public string FacilityName { get; set; }

        [StringLength(100)]
        public string UnitName { get; set; }

        [StringLength(100)]
        public string BedName { get; set; }

        [StringLength(100)]
        public string MonitorName { get; set; }

        [StringLength(100)]
        public string Channel { get; set; }
    }
}
