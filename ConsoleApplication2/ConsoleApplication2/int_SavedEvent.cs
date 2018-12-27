namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_SavedEvent
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public int_SavedEvent()
        {
            int_savedevent_calipers = new HashSet<int_savedevent_calipers>();
            int_savedevent_event_log = new HashSet<int_savedevent_event_log>();
            int_savedevent_vitals = new HashSet<int_savedevent_vitals>();
            int_SavedEvent_Waveform = new HashSet<int_SavedEvent_Waveform>();
        }

        [Key]
        [Column(Order = 0)]
        public Guid patient_id { get; set; }

        public Guid? orig_patient_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid event_id { get; set; }

        public DateTime insert_dt { get; set; }

        public Guid user_id { get; set; }

        public int orig_event_category { get; set; }

        public int orig_event_type { get; set; }

        public DateTime start_dt { get; set; }

        public long start_ms { get; set; }

        public long? center_ft { get; set; }

        public int duration { get; set; }

        public double value1 { get; set; }

        public double? value2 { get; set; }

        public int print_format { get; set; }

        [StringLength(50)]
        public string title { get; set; }

        [StringLength(200)]
        public string comment { get; set; }

        public byte annotate_data { get; set; }

        public byte beat_color { get; set; }

        public int num_waveforms { get; set; }

        public int sweep_speed { get; set; }

        public int minutes_per_page { get; set; }

        public int? thumbnailChannel { get; set; }

        public virtual int_savedevent_beat_time_log int_savedevent_beat_time_log { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<int_savedevent_calipers> int_savedevent_calipers { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<int_savedevent_event_log> int_savedevent_event_log { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<int_savedevent_vitals> int_savedevent_vitals { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<int_SavedEvent_Waveform> int_SavedEvent_Waveform { get; set; }
    }
}
