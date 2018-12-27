namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_waveform
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid patient_channel_id { get; set; }

        [Key]
        [Column(Order = 2)]
        public DateTime start_dt { get; set; }

        public DateTime? end_dt { get; set; }

        [Key]
        [Column(Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public long start_ft { get; set; }

        [Key]
        [Column(Order = 4)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public long end_ft { get; set; }

        [StringLength(8)]
        public string compress_method { get; set; }

        [Key]
        [Column(Order = 5, TypeName = "image")]
        public byte[] waveform_data { get; set; }
    }
}
