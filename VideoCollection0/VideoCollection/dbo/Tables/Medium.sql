CREATE TABLE [dbo].[Medium] (
    [MediumID] TINYINT       IDENTITY (1, 1) NOT NULL,
    [Format]   NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Medium_MediumID] PRIMARY KEY CLUSTERED ([MediumID] ASC),
    CONSTRAINT [CK_Medium_Format] CHECK (len([Format])>(0))
);

