namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_user
    {
        [Key]
        public Guid user_id { get; set; }

        public Guid user_role_id { get; set; }

        [StringLength(68)]
        public string user_sid { get; set; }

        public Guid? hcp_id { get; set; }

        [StringLength(64)]
        public string login_name { get; set; }
    }
}
