namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_AvailableDataTypes
    {
        public Guid? TypeId { get; set; }

        public Guid? TopicTypeId { get; set; }

        public Guid? DeviceSessionId { get; set; }

        [Key]
        public Guid PatientId { get; set; }

        public int? Active { get; set; }
    }
}
