CREATE TABLE [dbo].[InvoiceLine] (
    [InvoiceLineId] INT             IDENTITY (1, 1) NOT NULL,
    [InvoiceId]     INT             NOT NULL,
    [TrackId]       INT             NOT NULL,
    [UnitPrice]     NUMERIC (10, 2) NOT NULL,
    [Quantity]      INT             NOT NULL,
    CONSTRAINT [PK_InvoiceLine] PRIMARY KEY CLUSTERED ([InvoiceLineId] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_InvoiceLineInvoiceId] FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[Invoice] ([InvoiceId]),
    CONSTRAINT [FK_InvoiceLineTrackId] FOREIGN KEY ([TrackId]) REFERENCES [dbo].[Track] ([TrackId])
);


GO
CREATE NONCLUSTERED INDEX [IFK_InvoiceLineInvoiceId]
    ON [dbo].[InvoiceLine]([InvoiceId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IFK_InvoiceLineTrackId]
    ON [dbo].[InvoiceLine]([TrackId] ASC) WITH (FILLFACTOR = 100);

