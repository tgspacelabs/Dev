namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tbl_ConfigurationData
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(256)]
        public string ApplicationName { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(150)]
        public string SectionName { get; set; }

        [Column(TypeName = "xml")]
        public string SectionData { get; set; }

        public DateTime? UpdatedTimeStampUTC { get; set; }
    }
}
