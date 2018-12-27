namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_system_parameter
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int system_parameter_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(30)]
        public string name { get; set; }

        [StringLength(80)]
        public string parm_value { get; set; }

        public byte? active_flag { get; set; }

        public byte? after_discharge_sw { get; set; }

        public byte? debug_sw { get; set; }

        [StringLength(255)]
        public string descr { get; set; }
    }
}
