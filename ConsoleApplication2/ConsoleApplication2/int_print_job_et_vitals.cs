namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_print_job_et_vitals
    {
        public Guid Id { get; set; }

        public Guid? PatientId { get; set; }

        public Guid TopicSessionId { get; set; }

        [StringLength(80)]
        public string GDSCode { get; set; }

        [Required]
        [StringLength(255)]
        public string Name { get; set; }

        [StringLength(255)]
        public string Value { get; set; }

        public DateTime ResultTimeUTC { get; set; }
    }
}
