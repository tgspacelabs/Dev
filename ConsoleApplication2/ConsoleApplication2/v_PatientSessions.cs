namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_PatientSessions
    {
        [Key]
        [Column(Order = 0)]
        public Guid PATIENT_ID { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(102)]
        public string PATIENT_NAME { get; set; }

        [StringLength(50)]
        public string FIRST_NAME { get; set; }

        [StringLength(50)]
        public string MIDDLE_NAME { get; set; }

        [StringLength(50)]
        public string LAST_NAME { get; set; }

        [StringLength(202)]
        public string MONITOR_NAME { get; set; }

        [StringLength(180)]
        public string UNIT_NAME { get; set; }

        [StringLength(180)]
        public string UNIT_CODE { get; set; }

        public Guid? UNIT_ID { get; set; }

        [StringLength(180)]
        public string FACILITY_NAME { get; set; }

        [StringLength(180)]
        public string FACILITY_CODE { get; set; }

        public Guid? FACILITY_ID { get; set; }

        [StringLength(30)]
        public string ACCOUNT_ID { get; set; }

        [StringLength(30)]
        public string MRN_ID { get; set; }

        public DateTime? DOB { get; set; }

        [Key]
        [Column(Order = 2)]
        public DateTime ADMIT_TIME_UTC { get; set; }

        public DateTime? DISCHARGED_TIME_UTC { get; set; }

        public DateTime? LAST_RESULT_UTC { get; set; }

        [Key]
        [Column(Order = 3)]
        public Guid PATIENT_MONITOR_ID { get; set; }

        [Key]
        [Column(Order = 4)]
        [StringLength(1)]
        public string STATUS { get; set; }

        public Guid? FACILITY_PARENT_ID { get; set; }

        [StringLength(12)]
        public string ROOM { get; set; }

        [StringLength(100)]
        public string BED { get; set; }

        [StringLength(50)]
        public string SUBNET { get; set; }

        public Guid? DeviceId { get; set; }
    }
}
