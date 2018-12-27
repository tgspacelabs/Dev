namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_PrintJobsWaveform
    {
        [Key]
        [Column(Order = 0)]
        public Guid print_job_id { get; set; }

        public string page_number { get; set; }

        public int? seq_no { get; set; }

        [StringLength(30)]
        public string waveform_type { get; set; }

        public string duration { get; set; }

        [StringLength(30)]
        public string channel_type { get; set; }

        public int? module_num { get; set; }

        public int? channel_num { get; set; }

        public string sweep_speed { get; set; }

        public double? label_min { get; set; }

        public double? label_max { get; set; }

        public int? show_units { get; set; }

        public int? annotation_channel_type { get; set; }

        public int? offset { get; set; }

        public int? scale { get; set; }

        public int? primary_annotation { get; set; }

        public int? secondary_annotation { get; set; }

        public string waveform_data { get; set; }

        public int? grid_type { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(1)]
        public string scale_labels { get; set; }

        public short? sample_rate { get; set; }

        public int? row_dt { get; set; }

        public int? row_id { get; set; }
    }
}
