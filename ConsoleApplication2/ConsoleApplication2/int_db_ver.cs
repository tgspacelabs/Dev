namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_db_ver
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(30)]
        public string ver_code { get; set; }

        [Key]
        [Column(Order = 1)]
        public DateTime install_dt { get; set; }

        [StringLength(30)]
        public string status_cd { get; set; }

        [StringLength(255)]
        public string pre_install_pgm { get; set; }

        [StringLength(30)]
        public string pre_install_pgm_flags { get; set; }

        [StringLength(255)]
        public string install_pgm { get; set; }

        [StringLength(30)]
        public string install_pgm_flags { get; set; }

        [StringLength(255)]
        public string post_install_pgm { get; set; }

        [StringLength(30)]
        public string post_install_pgm_flags { get; set; }
    }
}
