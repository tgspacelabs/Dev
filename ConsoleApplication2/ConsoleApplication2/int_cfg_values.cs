namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_cfg_values
    {
        [Key]
        [StringLength(40)]
        public string keyname { get; set; }

        [Required]
        [StringLength(100)]
        public string keyvalue { get; set; }
    }
}
