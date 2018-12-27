namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_print_job_waveform
    {
        public Guid print_job_id { get; set; }

        public int page_number { get; set; }

        public int seq_no { get; set; }

        [Required]
        [StringLength(25)]
        public string waveform_type { get; set; }

        public double? duration { get; set; }

        [StringLength(50)]
        public string channel_type { get; set; }

        public int? module_num { get; set; }

        public int? channel_num { get; set; }

        public double? sweep_speed { get; set; }

        public double? label_min { get; set; }

        public double? label_max { get; set; }

        public byte? show_units { get; set; }

        public int? annotation_channel_type { get; set; }

        public int? offset { get; set; }

        public int? scale { get; set; }

        [StringLength(50)]
        public string primary_annotation { get; set; }

        [StringLength(50)]
        public string secondary_annotation { get; set; }

        [Column(TypeName = "text")]
        public string waveform_data { get; set; }

        public int? grid_type { get; set; }

        [StringLength(120)]
        public string scale_labels { get; set; }

        [Key]
        [Column(Order = 0, TypeName = "smalldatetime")]
        public DateTime row_dt { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid row_id { get; set; }
    }
}
