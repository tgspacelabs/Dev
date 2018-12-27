namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class gts_input_rate
    {
        [Key]
        public long input_rate_id { get; set; }

        [Required]
        [StringLength(20)]
        public string input_type { get; set; }

        public DateTime period_start { get; set; }

        public int period_len { get; set; }

        public int rate_counter { get; set; }

        public DateTime creation_date { get; set; }
    }
}
