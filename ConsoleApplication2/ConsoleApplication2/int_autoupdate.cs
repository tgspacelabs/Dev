namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_autoupdate
    {
        [StringLength(3)]
        public string prod { get; set; }

        public int? seq { get; set; }

        [Key]
        [StringLength(255)]
        public string action { get; set; }

        public byte? disabled { get; set; }
    }
}
