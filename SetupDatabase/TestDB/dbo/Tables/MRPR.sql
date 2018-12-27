﻿CREATE TABLE [dbo].[MRPR] (
    [MRID] INT NOT NULL,
    [PRID] INT NOT NULL,
    CONSTRAINT [PK_MRPR] PRIMARY KEY CLUSTERED ([MRID] ASC, [PRID] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_MRPR_MR] FOREIGN KEY ([MRID]) REFERENCES [dbo].[MR] ([MRID]),
    CONSTRAINT [FK_MRPR_PR] FOREIGN KEY ([PRID]) REFERENCES [dbo].[PR] ([PRID])
);

