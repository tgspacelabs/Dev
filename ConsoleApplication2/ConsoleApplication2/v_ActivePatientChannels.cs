namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_ActivePatientChannels
    {
        public Guid? TypeId { get; set; }

        public Guid? TopicTypeId { get; set; }

        [Key]
        public Guid PatientId { get; set; }

        public int? Active { get; set; }
    }
}
