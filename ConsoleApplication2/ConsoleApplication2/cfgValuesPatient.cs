namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("cfgValuesPatient")]
    public partial class cfgValuesPatient
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(25)]
        public string type_cd { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(40)]
        public string cfg_name { get; set; }

        [StringLength(1800)]
        public string cfg_value { get; set; }

        [Column(TypeName = "xml")]
        public string cfg_xml_value { get; set; }

        [Required]
        [StringLength(20)]
        public string value_type { get; set; }

        public DateTime timestamp { get; set; }
    }
}
