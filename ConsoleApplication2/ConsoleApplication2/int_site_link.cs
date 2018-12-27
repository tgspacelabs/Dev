namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_site_link
    {
        [Key]
        [Column(Order = 0)]
        public Guid link_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(100)]
        public string group_name { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int group_rank { get; set; }

        [Key]
        [Column(Order = 3)]
        [StringLength(100)]
        public string display_name { get; set; }

        [Key]
        [Column(Order = 4)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int display_rank { get; set; }

        [StringLength(100)]
        public string url { get; set; }
    }
}
