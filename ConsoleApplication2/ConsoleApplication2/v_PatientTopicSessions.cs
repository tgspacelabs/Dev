namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_PatientTopicSessions
    {
        [Key]
        [Column(Order = 0)]
        public Guid TopicSessionId { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid PatientId { get; set; }
    }
}
