﻿CREATE TYPE [dbo].[DTITLE]
    FROM NVARCHAR (50) NULL;


GO
GRANT REFERENCES
    ON TYPE::[dbo].[DTITLE] TO PUBLIC;

