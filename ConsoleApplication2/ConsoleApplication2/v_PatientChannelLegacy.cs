namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_PatientChannelLegacy
    {
        public Guid? DeviceSessionId { get; set; }

        [Key]
        public Guid PatientId { get; set; }

        public Guid? DeviceId { get; set; }

        public Guid? TypeId { get; set; }

        public Guid? TopicTypeId { get; set; }

        public Guid? ChannelTypeId { get; set; }

        public int? Active { get; set; }
    }
}
