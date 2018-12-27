namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Enum
    {
        [Key]
        [Column(Order = 0)]
        public Guid GroupId { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string Name { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Value { get; set; }

        [Required]
        [StringLength(250)]
        public string Comment { get; set; }

        public Guid? TopicTypeId { get; set; }

        [StringLength(50)]
        public string GroupName { get; set; }

        public Guid MetadataId { get; set; }
    }
}
