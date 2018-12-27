namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_user_group
    {
        [Key]
        [Column(Order = 0)]
        public Guid user_group_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(10)]
        public string group_name { get; set; }

        [StringLength(50)]
        public string group_descr { get; set; }
    }
}
