namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_LegacyChannelTypes
    {
        [Key]
        [Column(Order = 0)]
        public Guid ChannelTypeId { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid TopicTypeId { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(50)]
        public string TopicName { get; set; }

        public string CdiLabel { get; set; }

        [StringLength(50)]
        public string TypeName { get; set; }

        public Guid? TypeId { get; set; }

        public string SampleRate { get; set; }

        [Key]
        [Column(Order = 3)]
        public string ChannelCode { get; set; }

        [StringLength(20)]
        public string label { get; set; }
    }
}
