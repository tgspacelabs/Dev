namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_feature
    {
        [Key]
        [StringLength(25)]
        public string feature_cd { get; set; }

        [StringLength(120)]
        public string descr { get; set; }
    }
}
