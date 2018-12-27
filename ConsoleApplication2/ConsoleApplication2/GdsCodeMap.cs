namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("GdsCodeMap")]
    public partial class GdsCodeMap
    {
        [Key]
        [Column(Order = 0)]
        public Guid FeedTypeId { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(25)]
        public string Name { get; set; }

        [Required]
        [StringLength(25)]
        public string GdsCode { get; set; }

        public int CodeId { get; set; }

        [StringLength(25)]
        public string Units { get; set; }

        [StringLength(50)]
        public string Description { get; set; }
    }
}
