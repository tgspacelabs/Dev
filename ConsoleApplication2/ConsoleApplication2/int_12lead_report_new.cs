namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_12lead_report_new
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid report_id { get; set; }

        public DateTime report_dt { get; set; }

        public short? version_number { get; set; }

        [StringLength(50)]
        public string patient_name { get; set; }

        [StringLength(20)]
        public string id_number { get; set; }

        [StringLength(15)]
        public string birthdate { get; set; }

        [StringLength(15)]
        public string age { get; set; }

        [StringLength(1)]
        public string sex { get; set; }

        [StringLength(15)]
        public string height { get; set; }

        [StringLength(15)]
        public string weight { get; set; }

        [StringLength(15)]
        public string report_date { get; set; }

        [StringLength(15)]
        public string report_time { get; set; }

        public int? vent_rate { get; set; }

        public int? pr_interval { get; set; }

        public int? qt { get; set; }

        public int? qtc { get; set; }

        public int? qrs_duration { get; set; }

        public int? p_axis { get; set; }

        public int? qrs_axis { get; set; }

        public int? t_axis { get; set; }

        [Column(TypeName = "ntext")]
        public string interpretation { get; set; }

        public int sample_rate { get; set; }

        public int sample_count { get; set; }

        public int num_Ypoints { get; set; }

        public int baseline { get; set; }

        public int Ypoints_per_unit { get; set; }

        [Column(TypeName = "image")]
        public byte[] waveform_data { get; set; }

        public short? send_request { get; set; }

        public short? send_complete { get; set; }

        public DateTime? send_dt { get; set; }

        [Column(TypeName = "ntext")]
        public string interpretation_edits { get; set; }

        public Guid? user_id { get; set; }

        public virtual int_12lead_report int_12lead_report { get; set; }
    }
}
