namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("LiveData")]
    public partial class LiveData
    {
        [Key]
        [Column(Order = 0)]
        public long Sequence { get; set; }

        public Guid Id { get; set; }

        public Guid TopicInstanceId { get; set; }

        public Guid FeedTypeId { get; set; }

        [Required]
        [StringLength(25)]
        public string Name { get; set; }

        [StringLength(25)]
        public string Value { get; set; }

        [Key]
        [Column(Order = 1)]
        public DateTime TimestampUTC { get; set; }
    }
}
