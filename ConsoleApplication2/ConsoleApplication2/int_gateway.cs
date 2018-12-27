namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_gateway
    {
        [Key]
        public Guid gateway_id { get; set; }

        [StringLength(4)]
        public string gateway_type { get; set; }

        [StringLength(30)]
        public string network_id { get; set; }

        [StringLength(80)]
        public string hostname { get; set; }

        public byte? enable_sw { get; set; }

        [StringLength(30)]
        public string recv_app { get; set; }

        [StringLength(30)]
        public string send_app { get; set; }

        public int? reconnect_secs { get; set; }

        public Guid? organization_id { get; set; }

        public Guid? send_sys_id { get; set; }

        public int? results_usid { get; set; }

        public int? sleep_secs { get; set; }

        public byte? add_monitors_sw { get; set; }

        public byte? add_patients_sw { get; set; }

        public byte? add_results_sw { get; set; }

        public int? debug_level { get; set; }

        public Guid? unit_org_id { get; set; }

        [StringLength(4)]
        public string patient_id_type { get; set; }

        public byte? auto_assign_id_sw { get; set; }

        [StringLength(80)]
        public string new_mrn_format { get; set; }

        public byte? auto_chan_attach_sw { get; set; }

        public byte? live_vitals_sw { get; set; }

        public int? live_waveform_size { get; set; }

        public int? decnet_node { get; set; }

        [StringLength(5)]
        public string node_name { get; set; }

        [StringLength(255)]
        public string nodes_excluded { get; set; }

        [StringLength(255)]
        public string nodes_included { get; set; }

        public byte? timemaster_sw { get; set; }

        public int? waveform_size { get; set; }

        public byte? print_enabled_sw { get; set; }

        public byte? auto_record_alarm_sw { get; set; }

        public byte? collect_12_lead_sw { get; set; }

        public byte? print_auto_record_sw { get; set; }

        public bool? encryption_status { get; set; }
    }
}
