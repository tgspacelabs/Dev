namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_user_settings
    {
        [Key]
        [Column(Order = 0)]
        public Guid user_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(40)]
        public string cfg_name { get; set; }

        [Key]
        [Column(Order = 2, TypeName = "xml")]
        public string cfg_xml_value { get; set; }
    }
}
