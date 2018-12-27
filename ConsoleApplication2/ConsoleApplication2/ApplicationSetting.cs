namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class ApplicationSetting
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(50)]
        public string ApplicationType { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string InstanceId { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(50)]
        public string Key { get; set; }

        [StringLength(5000)]
        public string Value { get; set; }
    }
}
