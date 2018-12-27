namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("VitalsData")]
    public partial class VitalsData
    {
        [Key]
        [Column(Order = 0)]
        public long ID { get; set; }

        public Guid SetId { get; set; }

        [Required]
        [StringLength(25)]
        public string Name { get; set; }

        [StringLength(25)]
        public string Value { get; set; }

        public Guid TopicSessionId { get; set; }

        public Guid FeedTypeId { get; set; }

        [Key]
        [Column(Order = 1)]
        public DateTime TimestampUTC { get; set; }
    }
}
