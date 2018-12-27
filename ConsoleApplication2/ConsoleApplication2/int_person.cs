namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_person
    {
        [Key]
        public Guid person_id { get; set; }

        public Guid? new_patient_id { get; set; }

        [StringLength(50)]
        public string first_nm { get; set; }

        [StringLength(50)]
        public string middle_nm { get; set; }

        [StringLength(50)]
        public string last_nm { get; set; }

        [StringLength(5)]
        public string suffix { get; set; }

        [StringLength(40)]
        public string tel_no { get; set; }

        [StringLength(80)]
        public string line1_dsc { get; set; }

        [StringLength(80)]
        public string line2_dsc { get; set; }

        [StringLength(80)]
        public string line3_dsc { get; set; }

        [StringLength(30)]
        public string city_nm { get; set; }

        [StringLength(3)]
        public string state_code { get; set; }

        [StringLength(15)]
        public string zip_code { get; set; }

        public int? country_cid { get; set; }
    }
}
