namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("LeadConfiguration")]
    public partial class LeadConfiguration
    {
        [Key]
        [StringLength(50)]
        public string LeadName { get; set; }

        [StringLength(20)]
        public string MonitorLoaderValue { get; set; }

        [StringLength(20)]
        public string DataLoaderValue { get; set; }
    }
}
