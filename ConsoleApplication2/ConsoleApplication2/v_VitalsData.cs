namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_VitalsData
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public long Id { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid SetId { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(25)]
        public string Name { get; set; }

        [StringLength(25)]
        public string ResultValue { get; set; }

        public Guid? TopicTypeId { get; set; }

        [Key]
        [Column(Order = 3)]
        public Guid TopicSessionId { get; set; }

        [Key]
        [Column(Order = 4)]
        public DateTime DateTimeStampUTC { get; set; }

        [Key]
        [Column(Order = 5)]
        public Guid PatientId { get; set; }

        [Key]
        [Column(Order = 6)]
        [StringLength(25)]
        public string GdsCode { get; set; }

        [Key]
        [Column(Order = 7)]
        public Guid TypeId { get; set; }
    }
}
