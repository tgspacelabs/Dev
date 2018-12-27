namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_audit_log
    {
        [StringLength(256)]
        public string login_id { get; set; }

        [StringLength(50)]
        public string application_id { get; set; }

        [StringLength(50)]
        public string patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        [StringLength(160)]
        public string audit_type { get; set; }

        [StringLength(64)]
        public string device_name { get; set; }

        [StringLength(500)]
        public string audit_descr { get; set; }

        [Key]
        public DateTime audit_dt { get; set; }

        public Guid? encounter_id { get; set; }

        public Guid? detail_id { get; set; }
    }
}
