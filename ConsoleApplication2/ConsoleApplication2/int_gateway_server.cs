namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_gateway_server
    {
        [Key]
        [Column(Order = 0)]
        public Guid gateway_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string server_name { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int port { get; set; }
    }
}
