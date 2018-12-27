namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_send_sys
    {
        [Key]
        [Column(Order = 0)]
        public Guid sys_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid organization_id { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(180)]
        public string code { get; set; }

        [StringLength(180)]
        public string dsc { get; set; }
    }
}
