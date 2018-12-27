CREATE TABLE [dbo].[Atomic] (
    [AtomicID] INT           IDENTITY (1, 1) NOT NULL,
    [Type]     VARCHAR (100) NOT NULL,
    [Data]     VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Atomic_AtomicID] PRIMARY KEY CLUSTERED ([AtomicID] ASC)
);

