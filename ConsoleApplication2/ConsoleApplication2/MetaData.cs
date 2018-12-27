namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("MetaData")]
    public partial class MetaData
    {
        public Guid Id { get; set; }

        [Required]
        [StringLength(50)]
        public string Name { get; set; }

        [Required]
        public string Value { get; set; }

        public bool? IsLookUp { get; set; }

        public Guid? MetaDataId { get; set; }

        public Guid? TopicTypeId { get; set; }

        [StringLength(50)]
        public string EntityName { get; set; }

        [StringLength(50)]
        public string EntityMemberName { get; set; }

        public bool DisplayOnly { get; set; }

        public Guid TypeId { get; set; }
    }
}
