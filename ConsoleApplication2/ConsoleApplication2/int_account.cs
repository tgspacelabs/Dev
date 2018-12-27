namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class int_account
    {
        [Key]
        [Column(Order = 0)]
        public Guid account_id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid organization_id { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(40)]
        public string account_xid { get; set; }

        public int? account_status_cid { get; set; }

        public byte? bad_debt_sw { get; set; }

        [Column(TypeName = "smallmoney")]
        public decimal? tot_payments_amt { get; set; }

        [Column(TypeName = "smallmoney")]
        public decimal? tot_charges_amt { get; set; }

        [Column(TypeName = "smallmoney")]
        public decimal? tot_adjs_amt { get; set; }

        [Column(TypeName = "smallmoney")]
        public decimal? cur_bal_amt { get; set; }

        public DateTime? account_open_dt { get; set; }

        public DateTime? account_close_dt { get; set; }
    }
}
