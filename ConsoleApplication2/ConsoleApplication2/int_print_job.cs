namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_print_job
    {
        public Guid print_job_id { get; set; }

        public int page_number { get; set; }

        public Guid? patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        public DateTime job_net_dt { get; set; }

        [StringLength(120)]
        public string descr { get; set; }

        public int data_node { get; set; }

        public double? sweep_speed { get; set; }

        public double? duration { get; set; }

        public int? num_channels { get; set; }

        public Guid? alarm_id { get; set; }

        [StringLength(25)]
        public string job_type { get; set; }

        [StringLength(120)]
        public string title { get; set; }

        [StringLength(25)]
        public string bed { get; set; }

        [StringLength(25)]
        public string recording_time { get; set; }

        public int? byte_height { get; set; }

        public int? bitmap_height { get; set; }

        public int? bitmap_width { get; set; }

        public int? scale { get; set; }

        [StringLength(120)]
        public string annotation1 { get; set; }

        [StringLength(120)]
        public string annotation2 { get; set; }

        [StringLength(120)]
        public string annotation3 { get; set; }

        [StringLength(120)]
        public string annotation4 { get; set; }

        [Column(TypeName = "image")]
        public byte[] print_bitmap { get; set; }

        [Column(TypeName = "image")]
        public byte[] twelve_lead_data { get; set; }

        public byte? end_of_job_sw { get; set; }

        public byte? print_sw { get; set; }

        [StringLength(255)]
        public string printer_name { get; set; }

        public DateTime? last_printed_dt { get; set; }

        [StringLength(1)]
        public string status_code { get; set; }

        [StringLength(500)]
        public string status_msg { get; set; }

        [Column(TypeName = "image")]
        public byte[] start_rec { get; set; }

        [Key]
        [Column(Order = 0, TypeName = "smalldatetime")]
        public DateTime row_dt { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid row_id { get; set; }
    }
}
