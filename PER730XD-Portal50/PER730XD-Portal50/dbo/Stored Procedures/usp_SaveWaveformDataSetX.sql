CREATE PROCEDURE [dbo].[usp_SaveWaveformDataSetX]
    (
    @Id [uniqueidentifier],
    @SampleCount [int],
    @TypeName [varchar](50),
    @TypeId [uniqueidentifier],
    @Samples [varbinary](max),
    @Compressed [bit],
    @TopicSessionId [uniqueidentifier],
    @StartTimeUTC [datetime],
    @EndTimeUTC [datetime]
)
AS
BEGIN
    SET NOCOUNT ON

    INSERT INTO dbo.WaveformData
    (Id, SampleCount, TypeName, TypeId, Samples, Compressed, TopicSessionId, StartTimeUTC, EndTimeUTC)
    VALUES (@Id, @SampleCount, @TypeName, @TypeId, @Samples, @Compressed, @TopicSessionId, @StartTimeUTC, @EndTimeUTC)
END
