namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_alarm_waveform
    {
        [Key]
        [Column(Order = 0)]
        public Guid alarm_id { get; set; }

        public byte? retrieved { get; set; }

        [Column(TypeName = "text")]
        public string waveform_data { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int seq_num { get; set; }

        [Key]
        [Column(Order = 2)]
        public DateTime insert_dt { get; set; }
    }
}
