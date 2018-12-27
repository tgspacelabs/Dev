namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_user_role
    {
        [Key]
        [Column(Order = 0)]
        public Guid user_role_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(32)]
        public string role_name { get; set; }

        [StringLength(255)]
        public string role_desc { get; set; }
    }
}
