namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_channel_type
    {
        [Key]
        [Column(Order = 0)]
        public Guid channel_type_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int channel_code { get; set; }

        public int? gds_cid { get; set; }

        [StringLength(20)]
        public string label { get; set; }

        public short? freq { get; set; }

        public short? min_value { get; set; }

        public short? max_value { get; set; }

        public double? sweep_speed { get; set; }

        public byte? priority { get; set; }

        [StringLength(10)]
        public string type_cd { get; set; }

        [StringLength(25)]
        public string color { get; set; }

        [StringLength(10)]
        public string units { get; set; }
    }
}
