namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class HL7PatientLink
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int MessageNo { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(20)]
        public string PatientMrn { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(20)]
        public string PatientVisitNumber { get; set; }

        public Guid? PatientId { get; set; }

        public virtual HL7InboundMessage HL7InboundMessage { get; set; }
    }
}
