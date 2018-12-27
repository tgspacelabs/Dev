namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class TopicFeedType
    {
        [Key]
        public Guid FeedTypeId { get; set; }

        public Guid TopicTypeId { get; set; }

        public int ChannelCode { get; set; }

        public Guid ChannelTypeId { get; set; }

        public short? SampleRate { get; set; }

        [Required]
        [StringLength(250)]
        public string Label { get; set; }
    }
}
