﻿CREATE FUNCTION [dbo].[AddOneInline] (@n AS BIGINT)
RETURNS TABLE
    AS
RETURN
    SELECT
        @n + 1 AS [val];
