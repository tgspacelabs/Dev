namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_specimen_group
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int rank { get; set; }

        [StringLength(30)]
        public string source_cd { get; set; }

        [StringLength(30)]
        public string specimen_group { get; set; }
    }
}
