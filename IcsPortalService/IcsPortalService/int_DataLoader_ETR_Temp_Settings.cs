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
    
    public partial class int_DataLoader_ETR_Temp_Settings
    {
        public System.Guid gateway_id { get; set; }
        public string gateway_type { get; set; }
        public string farm_name { get; set; }
        public string network { get; set; }
        public Nullable<byte> et_do_not_store_waveforms { get; set; }
        public string include_trans_chs { get; set; }
        public string exclude_trans_chs { get; set; }
        public Nullable<byte> et_print_alarms { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
}