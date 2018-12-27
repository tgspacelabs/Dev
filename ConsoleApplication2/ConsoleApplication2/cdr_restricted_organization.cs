namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class cdr_restricted_organization
    {
        [Key]
        [Column(Order = 0)]
        public Guid organization_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid user_role_id { get; set; }
    }
}
