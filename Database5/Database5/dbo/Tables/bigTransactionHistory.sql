CREATE TABLE [dbo].[bigTransactionHistory] (
    [TransactionID]   INT          NOT NULL,
    [ProductID]       INT          NOT NULL,
    [TransactionDate] DATETIME     NULL,
    [Quantity]        INT          NULL,
    [ActualCost]      MONEY        NULL,
    [Filler]          VARCHAR (82) NULL,
    CONSTRAINT [pk_bigTransactionHistory] PRIMARY KEY CLUSTERED ([TransactionID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ProductId_TransactionDate]
    ON [dbo].[bigTransactionHistory]([ProductID] ASC, [TransactionDate] ASC)
    INCLUDE([Quantity], [ActualCost]);

