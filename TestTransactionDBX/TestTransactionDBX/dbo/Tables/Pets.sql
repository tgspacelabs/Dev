CREATE TABLE [dbo].[Pets] (
    [PetID]     INT          IDENTITY (1, 1) NOT NULL,
    [PetTypeID] INT          NULL,
    [PetName]   VARCHAR (10) NULL,
    [OwnerID]   INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([PetID] ASC) WITH (FILLFACTOR = 100),
    FOREIGN KEY ([OwnerID]) REFERENCES [dbo].[People] ([PersonID]),
    FOREIGN KEY ([PetTypeID]) REFERENCES [dbo].[PetTypes] ([PetTypeID])
);

