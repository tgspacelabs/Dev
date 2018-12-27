namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vwMetaDataValueNum")]
    public partial class vwMetaDataValueNum
    {
        [Key]
        [Column(Order = 0)]
        public Guid Id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string Name { get; set; }

        [Key]
        [Column(Order = 2)]
        public string Value { get; set; }

        public bool? IsLookUp { get; set; }

        public Guid? MetaDataId { get; set; }

        public Guid? TopicTypeId { get; set; }

        [StringLength(50)]
        public string EntityName { get; set; }

        [StringLength(50)]
        public string EntityMemberName { get; set; }

        [Key]
        [Column(Order = 3)]
        public bool DisplayOnly { get; set; }

        [Key]
        [Column(Order = 4)]
        public Guid TypeId { get; set; }

        public decimal? ValueNum { get; set; }
    }
}
