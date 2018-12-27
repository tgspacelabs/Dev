namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_DeviceSessionOrganization
    {
        [Key]
        public Guid DeviceSessionId { get; set; }

        public Guid? OrganizationId { get; set; }
    }
}
