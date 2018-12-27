namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_Patients
    {
        [Key]
        [Column(Order = 0)]
        public Guid PATIENT_ID { get; set; }

        [StringLength(50)]
        public string FIRST_NAME { get; set; }

        [StringLength(50)]
        public string MIDDLE_NAME { get; set; }

        [StringLength(50)]
        public string LAST_NAME { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(102)]
        public string PATIENT_NAME { get; set; }

        [StringLength(30)]
        public string ID1 { get; set; }

        [StringLength(30)]
        public string ID2 { get; set; }

        public DateTime? DOB { get; set; }

        [StringLength(180)]
        public string FACILITY_NAME { get; set; }
    }
}
