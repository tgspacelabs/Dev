namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class ResourceString
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(250)]
        public string Name { get; set; }

        [StringLength(250)]
        public string Value { get; set; }

        [StringLength(250)]
        public string Comment { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string Locale { get; set; }
    }
}
