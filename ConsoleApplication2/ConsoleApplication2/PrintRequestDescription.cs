namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class PrintRequestDescription
    {
        [Key]
        [Column(Order = 0)]
        public Guid RequestTypeEnumId { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int RequestTypeEnumValue { get; set; }

        [Required]
        [StringLength(25)]
        public string Value { get; set; }
    }
}
