CREATE TABLE [dbo].[ABC] (
    [Type]  VARCHAR (10) NOT NULL,
    [SrcID] INT          NOT NULL,
    [TgtID] INT          NOT NULL,
    CONSTRAINT [PK_ABC_Type_SrcID_TgtID] PRIMARY KEY CLUSTERED ([Type] ASC, [SrcID] ASC, [TgtID] ASC) WITH (FILLFACTOR = 100)
);

