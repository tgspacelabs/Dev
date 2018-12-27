namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_user_group_member
    {
        [Key]
        [Column(Order = 0)]
        public Guid user_group_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid user_id { get; set; }
    }
}
