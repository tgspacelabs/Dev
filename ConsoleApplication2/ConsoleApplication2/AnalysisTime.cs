namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("AnalysisTime")]
    public partial class AnalysisTime
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public AnalysisTime()
        {
            AnalysisEvents = new HashSet<AnalysisEvent>();
            int_beat_time_log = new HashSet<int_beat_time_log>();
            int_template_set_info = new HashSet<int_template_set_info>();
            PacerSpikeLogs = new HashSet<PacerSpikeLog>();
        }

        [Key]
        [Column(Order = 0)]
        public Guid user_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid patient_id { get; set; }

        public long? start_ft { get; set; }

        public long? end_ft { get; set; }

        public int analysis_type { get; set; }

        public DateTime insert_dt { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<AnalysisEvent> AnalysisEvents { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<int_beat_time_log> int_beat_time_log { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<int_template_set_info> int_template_set_info { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PacerSpikeLog> PacerSpikeLogs { get; set; }

        public virtual TrendData TrendData { get; set; }
    }
}
