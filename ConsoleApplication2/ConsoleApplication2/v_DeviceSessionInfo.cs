namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_DeviceSessionInfo
    {
        [Key]
        [Column(Order = 0)]
        public Guid DeviceSessionId { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(25)]
        public string Name { get; set; }

        [StringLength(100)]
        public string Value { get; set; }

        [Key]
        [Column(Order = 2)]
        public DateTime TimestampUTC { get; set; }
    }
}
