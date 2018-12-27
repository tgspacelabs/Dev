namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_translate
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(70)]
        public string translate_cd { get; set; }

        [StringLength(30)]
        public string form_id { get; set; }

        [StringLength(255)]
        public string enu { get; set; }

        [StringLength(255)]
        public string fra { get; set; }

        [StringLength(255)]
        public string deu { get; set; }

        [StringLength(255)]
        public string esp { get; set; }

        [StringLength(255)]
        public string ita { get; set; }

        [StringLength(255)]
        public string nld { get; set; }

        [StringLength(255)]
        public string chs { get; set; }

        [Key]
        [Column(Order = 1)]
        public DateTime insert_dt { get; set; }

        [StringLength(255)]
        public string Pol { get; set; }

        [StringLength(255)]
        public string ptb { get; set; }

        [StringLength(255)]
        public string cze { get; set; }
    }
}
