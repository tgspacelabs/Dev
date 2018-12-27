namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TrendData")]
    public partial class TrendData
    {
        [Key]
        [Column(Order = 0)]
        public Guid user_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid patient_id { get; set; }

        public int total_categories { get; set; }

        public long start_ft { get; set; }

        public int total_periods { get; set; }

        public int samples_per_period { get; set; }

        [Column(TypeName = "image")]
        public byte[] trend_data { get; set; }

        public virtual AnalysisTime AnalysisTime { get; set; }
    }
}
