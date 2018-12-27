namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_user_contact
    {
        [Key]
        [Column(Order = 0)]
        public Guid user_id { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int seq { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(80)]
        public string contact_descr { get; set; }

        [StringLength(80)]
        public string phone_num { get; set; }

        [StringLength(80)]
        public string address_1 { get; set; }

        [StringLength(80)]
        public string address_2 { get; set; }

        [StringLength(80)]
        public string address_3 { get; set; }

        [StringLength(40)]
        public string e_mail { get; set; }

        [StringLength(50)]
        public string city { get; set; }

        [StringLength(30)]
        public string state_province { get; set; }

        [StringLength(15)]
        public string zip_postal { get; set; }

        [StringLength(20)]
        public string country { get; set; }
    }
}
