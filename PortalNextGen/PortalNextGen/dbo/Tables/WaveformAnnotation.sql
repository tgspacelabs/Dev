CREATE TABLE [dbo].[WaveformAnnotation] (
    [WaveformAnnotationID] INT           IDENTITY (1, 1) NOT NULL,
    [PrintRequestID]       INT           NOT NULL,
    [ChannelIndex]         INT           NOT NULL,
    [Annotation]           VARCHAR (MAX) NOT NULL,
    [CreatedDateTime]      DATETIME2 (7) CONSTRAINT [DF_WaveformAnnotation_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_WaveformAnnotation_WaveformAnnotationID] PRIMARY KEY CLUSTERED ([WaveformAnnotationID] ASC),
    CONSTRAINT [FK_WaveformAnnotation_PrintRequest_PrintRequestID] FOREIGN KEY ([PrintRequestID]) REFERENCES [dbo].[PrintRequest] ([PrintRequestID])
);


GO
CREATE NONCLUSTERED INDEX [FK_WaveformAnnotation_PrintRequest_PrintRequestID]
    ON [dbo].[WaveformAnnotation]([PrintRequestID] ASC);

