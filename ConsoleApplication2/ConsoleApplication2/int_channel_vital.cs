namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_channel_vital
    {
        [Key]
        [Column(Order = 0)]
        public Guid channel_type_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int gds_cid { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(50)]
        public string format_string { get; set; }
    }
}
