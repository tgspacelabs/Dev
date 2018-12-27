namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_patient
    {
        [Key]
        public Guid patient_id { get; set; }

        public Guid? new_patient_id { get; set; }

        [StringLength(2)]
        public string organ_donor_sw { get; set; }

        [StringLength(2)]
        public string living_will_sw { get; set; }

        public byte? birth_order { get; set; }

        public int? veteran_status_cid { get; set; }

        [StringLength(50)]
        public string birth_place { get; set; }

        [StringLength(15)]
        public string ssn { get; set; }

        public int? mpi_ssn1 { get; set; }

        public int? mpi_ssn2 { get; set; }

        public int? mpi_ssn3 { get; set; }

        public int? mpi_ssn4 { get; set; }

        [StringLength(25)]
        public string driv_lic_no { get; set; }

        [StringLength(3)]
        public string mpi_dl1 { get; set; }

        [StringLength(3)]
        public string mpi_dl2 { get; set; }

        [StringLength(3)]
        public string mpi_dl3 { get; set; }

        [StringLength(3)]
        public string mpi_dl4 { get; set; }

        [StringLength(3)]
        public string driv_lic_state_code { get; set; }

        public DateTime? dob { get; set; }

        public DateTime? death_dt { get; set; }

        public int? nationality_cid { get; set; }

        public int? citizenship_cid { get; set; }

        public int? ethnic_group_cid { get; set; }

        public int? race_cid { get; set; }

        public int? gender_cid { get; set; }

        public int? primary_language_cid { get; set; }

        public int? marital_status_cid { get; set; }

        public int? religion_cid { get; set; }

        public int? monitor_interval { get; set; }

        public double? height { get; set; }

        public double? weight { get; set; }

        public double? bsa { get; set; }
    }
}
