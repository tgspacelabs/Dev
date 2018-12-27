namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_environment
    {
        [Key]
        [Column(Order = 0)]
        public Guid env_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string display_name { get; set; }

        [StringLength(200)]
        public string url { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int seq { get; set; }
    }
}
