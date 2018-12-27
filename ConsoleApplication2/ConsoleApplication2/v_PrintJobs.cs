namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_PrintJobs
    {
        [Key]
        [Column(Order = 0)]
        public Guid print_job_id { get; set; }

        public string page_number { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid patient_id { get; set; }

        public int? orig_patient_id { get; set; }

        public DateTime? job_net_dt { get; set; }

        public string descr { get; set; }

        public string data_node { get; set; }

        public string sweep_speed { get; set; }

        public string duration { get; set; }

        public string num_channels { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(52)]
        public string job_type { get; set; }

        public string bed { get; set; }

        public string recording_time { get; set; }

        public string annotation1 { get; set; }

        public string annotation2 { get; set; }

        public string annotation3 { get; set; }

        public string annotation4 { get; set; }

        public int? print_bitmap { get; set; }

        public int? twelve_lead_data { get; set; }

        public int? end_of_job_sw { get; set; }

        public int? print_sw { get; set; }

        public int? printer_name { get; set; }

        public int? last_printed_dt { get; set; }

        public int? status_code { get; set; }

        public int? status_msg { get; set; }

        public int? start_rec { get; set; }

        public int? row_dt { get; set; }

        public int? row_id { get; set; }
    }
}
