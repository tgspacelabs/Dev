namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class PrintRequest
    {
        [Key]
        [Column(Order = 0)]
        public Guid Id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid PrintJobId { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid RequestTypeEnumId { get; set; }

        [Key]
        [Column(Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int RequestTypeEnumValue { get; set; }

        [Key]
        [Column(Order = 4)]
        public DateTime TimestampUTC { get; set; }
    }
}
