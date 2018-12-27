namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("PrintRequestData")]
    public partial class PrintRequestData
    {
        [Key]
        [Column(Order = 0)]
        public Guid Id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid PrintRequestId { get; set; }

        [StringLength(50)]
        public string Name { get; set; }

        public string Value { get; set; }
    }
}
