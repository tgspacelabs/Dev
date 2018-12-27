namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("LogData")]
    public partial class LogData
    {
        [Key]
        public Guid LogId { get; set; }

        public DateTime DateTime { get; set; }

        [StringLength(256)]
        public string PatientID { get; set; }

        [StringLength(256)]
        public string Application { get; set; }

        [StringLength(256)]
        public string DeviceName { get; set; }

        [Required]
        public string Message { get; set; }

        public string LocalizedMessage { get; set; }

        public int? MessageId { get; set; }

        [Required]
        [StringLength(64)]
        public string LogType { get; set; }
    }
}
