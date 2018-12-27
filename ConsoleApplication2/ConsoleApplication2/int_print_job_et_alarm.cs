namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_print_job_et_alarm
    {
        [Key]
        public Guid AlarmId { get; set; }

        public Guid? PatientId { get; set; }

        public Guid TopicSessionId { get; set; }

        public Guid DeviceSessionId { get; set; }

        public DateTime AlarmStartTimeUTC { get; set; }

        public DateTime? AlarmEndTimeUTC { get; set; }

        [StringLength(50)]
        public string StrTitleLabel { get; set; }

        [StringLength(50)]
        public string FirstName { get; set; }

        [StringLength(50)]
        public string LastName { get; set; }

        [StringLength(150)]
        public string FullName { get; set; }

        [StringLength(30)]
        public string ID1 { get; set; }

        [StringLength(30)]
        public string ID2 { get; set; }

        [StringLength(40)]
        public string DOB { get; set; }

        [StringLength(180)]
        public string FacilityName { get; set; }

        [StringLength(180)]
        public string UnitName { get; set; }

        [Required]
        [StringLength(255)]
        public string MonitorName { get; set; }

        [Required]
        [StringLength(120)]
        public string StrMessage { get; set; }

        [StringLength(120)]
        public string StrLimitFormat { get; set; }

        [StringLength(120)]
        public string StrValueFormat { get; set; }

        [StringLength(120)]
        public string ViolatingValue { get; set; }

        [StringLength(120)]
        public string SettingViolated { get; set; }

        [Column(TypeName = "smalldatetime")]
        public DateTime RowLastUpdatedOn { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long Sequence { get; set; }
    }
}
