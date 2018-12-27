namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("AuditLogData")]
    public partial class AuditLogData
    {
        [Key]
        public Guid AuditId { get; set; }

        public DateTime DateTime { get; set; }

        [Required]
        [StringLength(256)]
        public string PatientID { get; set; }

        [StringLength(256)]
        public string Application { get; set; }

        [StringLength(256)]
        public string DeviceName { get; set; }

        [Required]
        public string Message { get; set; }

        [Required]
        [StringLength(256)]
        public string ItemName { get; set; }

        [Required]
        public string OriginalValue { get; set; }

        [Required]
        public string NewValue { get; set; }

        [Required]
        [StringLength(64)]
        public string ChangedBy { get; set; }

        [Required]
        [MaxLength(20)]
        public byte[] HashedValue { get; set; }
    }
}
