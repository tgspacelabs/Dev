namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_LegacyMonitorCombined
    {
        [Key]
        [Column(Order = 0)]
        public Guid monitor_id { get; set; }

        public Guid? unit_org_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(15)]
        public string network_id { get; set; }

        public int? node_id { get; set; }

        public int? bed_id { get; set; }

        public int? bed_cd { get; set; }

        public int? room { get; set; }

        public int? monitor_dsc { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(50)]
        public string monitor_name { get; set; }

        [StringLength(5)]
        public string monitor_type_cd { get; set; }

        [StringLength(50)]
        public string subnet { get; set; }
    }
}
