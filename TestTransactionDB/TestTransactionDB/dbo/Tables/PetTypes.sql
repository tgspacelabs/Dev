CREATE TABLE [dbo].[PetTypes] (
    [PetTypeID] INT          IDENTITY (1, 1) NOT NULL,
    [PetType]   VARCHAR (10) NULL,
    PRIMARY KEY CLUSTERED ([PetTypeID] ASC)
);

