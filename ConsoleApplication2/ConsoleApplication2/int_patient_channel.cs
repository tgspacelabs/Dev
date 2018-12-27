namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_patient_channel
    {
        [Key]
        [Column(Order = 0)]
        public Guid patient_channel_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid patient_monitor_id { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        [Key]
        [Column(Order = 3)]
        public Guid monitor_id { get; set; }

        [Key]
        [Column(Order = 4)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int module_num { get; set; }

        [Key]
        [Column(Order = 5)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int channel_num { get; set; }

        public Guid? channel_type_id { get; set; }

        public byte? collect_sw { get; set; }

        public byte? active_sw { get; set; }
    }
}
