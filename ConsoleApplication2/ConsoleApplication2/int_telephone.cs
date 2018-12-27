namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_telephone
    {
        [Key]
        [Column(Order = 0)]
        public Guid phone_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(1)]
        public string phone_loc_cd { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(1)]
        public string phone_type_cd { get; set; }

        [Key]
        [Column(Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int seq_no { get; set; }

        public Guid? orig_patient_id { get; set; }

        [Key]
        [Column(Order = 4)]
        public byte active_sw { get; set; }

        [StringLength(40)]
        public string tel_no { get; set; }

        [StringLength(12)]
        public string ext_no { get; set; }

        [StringLength(3)]
        public string areacode { get; set; }

        public short? mpi_tel1 { get; set; }

        public short? mpi_tel2 { get; set; }

        public short? mpi_tel3 { get; set; }

        public DateTime? start_dt { get; set; }
    }
}
