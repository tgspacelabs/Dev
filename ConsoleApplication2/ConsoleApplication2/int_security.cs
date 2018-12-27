namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_security
    {
        public Guid? user_id { get; set; }

        public Guid? user_role_id { get; set; }

        [StringLength(3)]
        public string application_id { get; set; }

        [Key]
        [Column(TypeName = "xml")]
        public string xml_data { get; set; }
    }
}
