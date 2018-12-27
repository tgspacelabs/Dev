//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace IcsPortalService
{
    using System;
    using System.Collections.Generic;
    
    public partial class int_print_job_waveform
    {
        public System.Guid print_job_id { get; set; }
        public int page_number { get; set; }
        public int seq_no { get; set; }
        public string waveform_type { get; set; }
        public Nullable<double> duration { get; set; }
        public string channel_type { get; set; }
        public Nullable<int> module_num { get; set; }
        public Nullable<int> channel_num { get; set; }
        public Nullable<double> sweep_speed { get; set; }
        public Nullable<double> label_min { get; set; }
        public Nullable<double> label_max { get; set; }
        public Nullable<byte> show_units { get; set; }
        public Nullable<int> annotation_channel_type { get; set; }
        public Nullable<int> offset { get; set; }
        public Nullable<int> scale { get; set; }
        public string primary_annotation { get; set; }
        public string secondary_annotation { get; set; }
        public string waveform_data { get; set; }
        public Nullable<int> grid_type { get; set; }
        public string scale_labels { get; set; }
        public System.DateTime row_dt { get; set; }
        public System.Guid row_id { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}
