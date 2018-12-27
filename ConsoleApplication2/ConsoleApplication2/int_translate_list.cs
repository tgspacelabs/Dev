namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_translate_list
    {
        [Key]
        [Column(Order = 0)]
        public Guid list_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(40)]
        public string translate_cd { get; set; }
    }
}
