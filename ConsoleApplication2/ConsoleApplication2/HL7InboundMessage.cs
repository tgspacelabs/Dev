namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class HL7InboundMessage
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public HL7InboundMessage()
        {
            HL7PatientLink = new HashSet<HL7PatientLink>();
        }

        [Key]
        public int MessageNo { get; set; }

        [Required]
        [StringLength(1)]
        public string MessageStatus { get; set; }

        [Required]
        public string Hl7Message { get; set; }

        public string Hl7MessageResponse { get; set; }

        [Required]
        [StringLength(180)]
        public string MessageSendingApplication { get; set; }

        [Required]
        [StringLength(180)]
        public string MessageSendingFacility { get; set; }

        [Required]
        [StringLength(3)]
        public string MessageType { get; set; }

        [Required]
        [StringLength(3)]
        public string MessageTypeEventCode { get; set; }

        [Required]
        [StringLength(20)]
        public string MessageControlId { get; set; }

        [Required]
        [StringLength(60)]
        public string MessageVersion { get; set; }

        public DateTime MessageHeaderDate { get; set; }

        public DateTime MessageQueuedDate { get; set; }

        public DateTime? MessageProcessedDate { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<HL7PatientLink> HL7PatientLink { get; set; }
    }
}
