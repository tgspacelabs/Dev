namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_flowsheet
    {
        public Guid? flowsheet_id { get; set; }

        [Key]
        [StringLength(50)]
        public string flowsheet_type { get; set; }

        public Guid? owner_id { get; set; }

        [StringLength(50)]
        public string name { get; set; }

        [StringLength(50)]
        public string description { get; set; }

        public int? seq { get; set; }

        public byte? display_in_menu { get; set; }
    }
}
