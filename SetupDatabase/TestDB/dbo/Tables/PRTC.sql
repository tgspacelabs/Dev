﻿CREATE TABLE [dbo].[PRTC] (
    [PRID] INT NOT NULL,
    [TCID] INT NOT NULL,
    CONSTRAINT [PK_PRTC] PRIMARY KEY CLUSTERED ([PRID] ASC, [TCID] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_PRTC_PR] FOREIGN KEY ([PRID]) REFERENCES [dbo].[PR] ([PRID]),
    CONSTRAINT [FK_PRTC_TC] FOREIGN KEY ([TCID]) REFERENCES [dbo].[TC] ([TCID])
);

