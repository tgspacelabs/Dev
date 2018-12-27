namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_bin_info
    {
        [Key]
        [Column(Order = 0)]
        public Guid user_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid patient_id { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int template_set_index { get; set; }

        [Key]
        [Column(Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int template_index { get; set; }

        public int bin_number { get; set; }

        public int source { get; set; }

        public int beat_count { get; set; }

        public int first_beat_number { get; set; }

        public int non_ignored_count { get; set; }

        public int first_non_ignored_beat { get; set; }

        public int iso_offset { get; set; }

        public int st_offset { get; set; }

        public int i_point { get; set; }

        public int j_point { get; set; }

        public int st_class { get; set; }

        public int singles_bin { get; set; }

        public int edit_bin { get; set; }

        public int subclass_number { get; set; }

        [Column(TypeName = "image")]
        public byte[] bin_image { get; set; }

        public virtual int_template_set_info int_template_set_info { get; set; }
    }
}
