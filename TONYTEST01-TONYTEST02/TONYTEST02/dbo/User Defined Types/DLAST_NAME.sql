﻿CREATE TYPE [dbo].[DLAST_NAME]
    FROM NVARCHAR (40) NULL;


GO
GRANT REFERENCES
    ON TYPE::[dbo].[DLAST_NAME] TO PUBLIC;
