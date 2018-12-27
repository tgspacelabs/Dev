CREATE FUNCTION [dbo].[AddOneInline] (@n AS BIGINT)
RETURNS BIGINT
AS
BEGIN
    RETURN 
        (SELECT
            @n + 1 AS [val]);
END;
