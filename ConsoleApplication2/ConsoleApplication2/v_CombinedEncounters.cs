namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_CombinedEncounters
    {
        [StringLength(50)]
        public string FIRST_NAME { get; set; }

        [StringLength(50)]
        public string LAST_NAME { get; set; }

        [StringLength(30)]
        public string MRN_ID { get; set; }

        [StringLength(30)]
        public string ACCOUNT_ID { get; set; }

        public DateTime? DOB { get; set; }

        public Guid? FACILITY_ID { get; set; }

        public Guid? UNIT_ID { get; set; }

        [StringLength(80)]
        public string ROOM { get; set; }

        [StringLength(100)]
        public string BED { get; set; }

        [StringLength(202)]
        public string MONITOR_NAME { get; set; }

        public DateTime? LAST_RESULT { get; set; }

        public DateTime? ADMIT { get; set; }

        public DateTime? DISCHARGED { get; set; }

        [StringLength(50)]
        public string SUBNET { get; set; }

        [Key]
        [Column(Order = 0)]
        public Guid PATIENT_ID { get; set; }

        [StringLength(3)]
        public string STATUS_CD { get; set; }

        public int? MONITOR_CREATED { get; set; }

        public Guid? FACILITY_PARENT_ID { get; set; }

        public Guid? PATIENT_MONITOR_ID { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(1)]
        public string MERGE_CD { get; set; }
    }
}
