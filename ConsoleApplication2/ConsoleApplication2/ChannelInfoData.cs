namespace ConsoleApplication2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ChannelInfoData")]
    public partial class ChannelInfoData
    {
        public Guid Id { get; set; }

        public Guid PrintRequestId { get; set; }

        public int ChannelIndex { get; set; }

        public bool IsPrimaryECG { get; set; }

        public bool IsSecondaryECG { get; set; }

        public bool IsNonWaveformType { get; set; }

        public int? SampleRate { get; set; }

        public int? Scale { get; set; }

        public double? ScaleValue { get; set; }

        public double? ScaleMin { get; set; }

        public double? ScaleMax { get; set; }

        public int? ScaleTypeEnumValue { get; set; }

        public int? Baseline { get; set; }

        public int? YPointsPerUnit { get; set; }

        public int ChannelType { get; set; }
    }
}
