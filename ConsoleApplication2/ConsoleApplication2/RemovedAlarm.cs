namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class RemovedAlarm
    {
        [Key]
        public Guid AlarmId { get; set; }

        public byte? Removed { get; set; }
    }
}
