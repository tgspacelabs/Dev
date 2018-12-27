namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_FeedGdsCodes
    {
        [Key]
        [Column(Order = 0)]
        public Guid FeedTypeId { get; set; }

        [Key]
        [Column(Order = 1)]
        public string GdsCode { get; set; }
    }
}
