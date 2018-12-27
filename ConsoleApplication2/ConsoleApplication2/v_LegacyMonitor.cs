namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_LegacyMonitor
    {
        [Key]
        [Column(Order = 0)]
        public Guid Id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(36)]
        public string UnitOrgId { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(5)]
        public string NetworkId { get; set; }

        public int? NodeId { get; set; }

        public int? BedId { get; set; }

        public int? BedCd { get; set; }

        public int? Room { get; set; }

        public int? Description { get; set; }

        [Key]
        [Column(Order = 3)]
        [StringLength(50)]
        public string Name { get; set; }

        [Key]
        [Column(Order = 4)]
        [StringLength(5)]
        public string Type { get; set; }

        [Key]
        [Column(Order = 5)]
        [StringLength(5)]
        public string Subnet { get; set; }
    }
}
