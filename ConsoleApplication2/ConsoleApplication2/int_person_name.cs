namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_person_name
    {
        [Key]
        [Column(Order = 0)]
        public Guid person_nm_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(2)]
        public string recognize_nm_cd { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int seq_no { get; set; }

        public Guid? orig_patient_id { get; set; }

        [Key]
        [Column(Order = 3)]
        public byte active_sw { get; set; }

        [StringLength(4)]
        public string prefix { get; set; }

        [StringLength(50)]
        public string first_nm { get; set; }

        [StringLength(50)]
        public string middle_nm { get; set; }

        [StringLength(50)]
        public string last_nm { get; set; }

        [StringLength(5)]
        public string suffix { get; set; }

        [StringLength(20)]
        public string degree { get; set; }

        [StringLength(20)]
        public string mpi_lname_cons { get; set; }

        [StringLength(20)]
        public string mpi_fname_cons { get; set; }

        [StringLength(20)]
        public string mpi_mname_cons { get; set; }

        public DateTime? start_dt { get; set; }
    }
}
