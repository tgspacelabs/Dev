namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_Monitors
    {
        [Key]
        [Column(Order = 0)]
        public Guid monitor_id { get; set; }

        public Guid? unit_org_id { get; set; }

        [StringLength(100)]
        public string network_id { get; set; }

        [StringLength(15)]
        public string node_id { get; set; }

        [StringLength(3)]
        public string bed_id { get; set; }

        [StringLength(100)]
        public string channel { get; set; }

        [StringLength(100)]
        public string bed_cd { get; set; }

        [StringLength(12)]
        public string room { get; set; }

        [StringLength(50)]
        public string monitor_dsc { get; set; }

        [StringLength(100)]
        public string monitor_name { get; set; }

        [StringLength(5)]
        public string monitor_type_cd { get; set; }

        [StringLength(50)]
        public string subnet { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(6)]
        public string assignment_cd { get; set; }
    }
}
