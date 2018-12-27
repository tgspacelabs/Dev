namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("PatientData")]
    public partial class PatientData
    {
        public Guid Id { get; set; }

        public Guid PatientSessionId { get; set; }

        public Guid? DeviceSessionId { get; set; }

        [StringLength(50)]
        public string LastName { get; set; }

        [StringLength(50)]
        public string MiddleName { get; set; }

        [StringLength(50)]
        public string FirstName { get; set; }

        [StringLength(150)]
        public string FullName { get; set; }

        [StringLength(50)]
        public string Gender { get; set; }

        [StringLength(30)]
        public string ID1 { get; set; }

        [StringLength(30)]
        public string ID2 { get; set; }

        [StringLength(50)]
        public string DOB { get; set; }

        [StringLength(25)]
        public string Weight { get; set; }

        [StringLength(25)]
        public string WeightUOM { get; set; }

        [StringLength(25)]
        public string Height { get; set; }

        [StringLength(25)]
        public string HeightUOM { get; set; }

        [StringLength(25)]
        public string BSA { get; set; }

        [StringLength(50)]
        public string Location { get; set; }

        [StringLength(150)]
        public string PatientType { get; set; }

        public DateTime TimestampUTC { get; set; }

        [Key]
        public long Sequence { get; set; }
    }
}
