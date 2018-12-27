namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class gts_waveform_index_rate
    {
        [Key]
        public long index_rate_id { get; set; }

        public int Wave_Rate_Index { get; set; }

        public int Current_Wavecount { get; set; }

        public int Active_Waveform { get; set; }

        public DateTime period_start { get; set; }

        public int period_len { get; set; }

        public DateTime creation_date { get; set; }
    }
}
