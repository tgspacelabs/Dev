namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_code_category
    {
        [Key]
        [StringLength(4)]
        public string cat_code { get; set; }

        [StringLength(80)]
        public string cat_name { get; set; }
    }
}
