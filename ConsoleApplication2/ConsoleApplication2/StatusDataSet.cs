namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class StatusDataSet
    {
        public Guid Id { get; set; }

        public Guid TopicSessionId { get; set; }

        public Guid FeedTypeId { get; set; }

        public DateTime TimestampUTC { get; set; }
    }
}
