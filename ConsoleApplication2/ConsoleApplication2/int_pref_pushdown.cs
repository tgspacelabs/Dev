namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_pref_pushdown
    {
        public Guid? user_id { get; set; }

        public Guid? user_role_id { get; set; }

        [Key]
        [Column(Order = 0)]
        [StringLength(255)]
        public string node_path { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(4000)]
        public string xml_data { get; set; }

        public DateTime? mod_dt { get; set; }
    }
}
