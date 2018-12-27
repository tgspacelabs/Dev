namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DeviceInfoData")]
    public partial class DeviceInfoData
    {
        public Guid Id { get; set; }

        public Guid DeviceSessionId { get; set; }

        [Required]
        [StringLength(25)]
        public string Name { get; set; }

        [StringLength(100)]
        public string Value { get; set; }

        public DateTime TimestampUTC { get; set; }
    }
}
