namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_msg_template
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int msg_template_id { get; set; }

        [StringLength(255)]
        public string msg_text { get; set; }
    }
}
