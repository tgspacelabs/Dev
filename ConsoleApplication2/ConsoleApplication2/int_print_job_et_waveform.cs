namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_print_job_et_waveform
    {
        public Guid Id { get; set; }

        public Guid DeviceSessionId { get; set; }

        public DateTime StartTimeUTC { get; set; }

        public DateTime EndTimeUTC { get; set; }

        public int SampleRate { get; set; }

        [Required]
        public byte[] WaveformData { get; set; }

        public int ChannelCode { get; set; }

        [Required]
        [StringLength(255)]
        public string CdiLabel { get; set; }
    }
}
