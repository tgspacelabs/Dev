//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace IcsPortalService
{
    using System;
    using System.Collections.Generic;
    
    public partial class int_account
    {
        public System.Guid account_id { get; set; }
        public System.Guid organization_id { get; set; }
        public string account_xid { get; set; }
        public Nullable<int> account_status_cid { get; set; }
        public Nullable<byte> bad_debt_sw { get; set; }
        public Nullable<decimal> tot_payments_amt { get; set; }
        public Nullable<decimal> tot_charges_amt { get; set; }
        public Nullable<decimal> tot_adjs_amt { get; set; }
        public Nullable<decimal> cur_bal_amt { get; set; }
        public Nullable<System.DateTime> account_open_dt { get; set; }
        public Nullable<System.DateTime> account_close_dt { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}
