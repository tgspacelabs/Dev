namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_address
    {
        [Key]
        [Column(Order = 0)]
        public Guid address_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(1)]
        public string addr_loc_cd { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(1)]
        public string addr_type_cd { get; set; }

        [Key]
        [Column(Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int seq_no { get; set; }

        public byte? active_sw { get; set; }

        public Guid? orig_patient_id { get; set; }

        [StringLength(80)]
        public string line1_dsc { get; set; }

        [StringLength(80)]
        public string line2_dsc { get; set; }

        [StringLength(80)]
        public string line3_dsc { get; set; }

        [StringLength(30)]
        public string city_nm { get; set; }

        public int? county_cid { get; set; }

        [StringLength(3)]
        public string state_code { get; set; }

        public int? country_cid { get; set; }

        [StringLength(15)]
        public string zip_code { get; set; }

        public DateTime? start_dt { get; set; }
    }
}
