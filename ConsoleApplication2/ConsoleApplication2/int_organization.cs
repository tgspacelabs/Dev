namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_organization
    {
        [Key]
        public Guid organization_id { get; set; }

        [StringLength(1)]
        public string category_cd { get; set; }

        public Guid? parent_organization_id { get; set; }

        [StringLength(180)]
        public string organization_cd { get; set; }

        [StringLength(180)]
        public string organization_nm { get; set; }

        public byte? in_default_search { get; set; }

        public byte? monitor_disable_sw { get; set; }

        public int? auto_collect_interval { get; set; }

        public int? outbound_interval { get; set; }

        [StringLength(255)]
        public string printer_name { get; set; }

        [StringLength(255)]
        public string alarm_printer_name { get; set; }
    }
}
