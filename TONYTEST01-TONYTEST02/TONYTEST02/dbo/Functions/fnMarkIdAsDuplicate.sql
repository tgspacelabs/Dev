






CREATE FUNCTION [dbo].[fnMarkIdAsDuplicate](@id AS VARCHAR(15))
RETURNS VARCHAR(15)
WITH RETURNS NULL ON NULL INPUT
AS
BEGIN
	RETURN CASE WHEN @id LIKE '*_*%' THEN CASE WHEN LEFT(@id, 3) = '***' THEN '*1*' + SUBSTRING(@id, 4, 12)
					                           WHEN SUBSTRING(@id, 2, 1) LIKE '[0-8]' THEN '*' + CAST(CAST(SUBSTRING(@id, 2, 1) AS INT) + 1 AS VARCHAR)+ '*' + RIGHT(@id, 12)
											   ELSE '***' + RIGHT(@id, 12) END
			    ELSE '***' + RIGHT(@id, 12) END					
END

