namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_pref_diff
    {
        public Guid? user_id { get; set; }

        public Guid? user_role_id { get; set; }

        [Key]
        [StringLength(255)]
        public string node_path { get; set; }

        public byte? changed_at_global { get; set; }
    }
}
