CREATE TABLE [dbo].[Numeric] (
    [NumericID]       BIGINT        NOT NULL,
    [ParameterID]     INT           NOT NULL,
    [CategoryValue]   INT           NOT NULL,
    [Type]            INT           NOT NULL,
    [Subtype]         INT           NOT NULL,
    [Value1]          REAL          NOT NULL,
    [Value2]          REAL          NOT NULL,
    [Status]          INT           NOT NULL,
    [ValidLeads]      INT           NOT NULL,
    [FeedTypeID]      INT           NOT NULL,
    [Timestamp]       DATETIME2 (7) NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Numeric_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Numeric_NumericID] PRIMARY KEY CLUSTERED ([NumericID] ASC),
    CONSTRAINT [FK_Numeric_Parameter_ParameterID] FOREIGN KEY ([ParameterID]) REFERENCES [dbo].[Parameter] ([ParameterID])
);


GO
CREATE NONCLUSTERED INDEX [FK_Numeric_Parameter_ParameterID]
    ON [dbo].[Numeric]([ParameterID] ASC);

