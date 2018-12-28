CREATE TABLE [dbo].[WaveformPrint] (
    [WaveformPrintID] INT           IDENTITY (1, 1) NOT NULL,
    [PrintRequestID]  INT           NOT NULL,
    [ChannelIndex]    INT           NOT NULL,
    [NumSamples]      INT           NOT NULL,
    [Samples]         VARCHAR (MAX) NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_WaveformPrint_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_WaveformPrint_WaveformPrintID] PRIMARY KEY CLUSTERED ([WaveformPrintID] ASC),
    CONSTRAINT [FK_WaveformPrint_PrintRequest_PrintRequestID] FOREIGN KEY ([PrintRequestID]) REFERENCES [dbo].[PrintRequest] ([PrintRequestID])
);


GO
CREATE NONCLUSTERED INDEX [FK_WaveformPrint_PrintRequest_PrintRequestID]
    ON [dbo].[WaveformPrint]([PrintRequestID] ASC);

