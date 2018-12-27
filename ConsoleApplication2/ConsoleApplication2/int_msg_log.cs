namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_msg_log
    {
        [Key]
        [Column(Order = 0)]
        public Guid msg_log_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public DateTime msg_dt { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(20)]
        public string product { get; set; }

        public int? msg_template_id { get; set; }

        [StringLength(50)]
        public string external_id { get; set; }

        [Column(TypeName = "ntext")]
        public string msg_text { get; set; }

        [StringLength(20)]
        public string type { get; set; }
    }
}
