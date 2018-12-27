namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_12lead_report_edit
    {
        [Key]
        [Column(Order = 0)]
        public Guid report_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public DateTime insert_dt { get; set; }

        public Guid? user_id { get; set; }

        public short? version_number { get; set; }

        [StringLength(80)]
        public string patient_name { get; set; }

        [StringLength(80)]
        public string report_date { get; set; }

        [StringLength(80)]
        public string report_time { get; set; }

        [StringLength(80)]
        public string id_number { get; set; }

        [StringLength(80)]
        public string birthdate { get; set; }

        [StringLength(80)]
        public string age { get; set; }

        [StringLength(80)]
        public string sex { get; set; }

        [StringLength(80)]
        public string height { get; set; }

        [StringLength(80)]
        public string weight { get; set; }

        public int? vent_rate { get; set; }

        public int? pr_interval { get; set; }

        public int? qt { get; set; }

        public int? qtc { get; set; }

        public int? qrs_duration { get; set; }

        public int? p_axis { get; set; }

        public int? qrs_axis { get; set; }

        public int? t_axis { get; set; }

        [Column(TypeName = "text")]
        public string interpretation { get; set; }
    }
}
