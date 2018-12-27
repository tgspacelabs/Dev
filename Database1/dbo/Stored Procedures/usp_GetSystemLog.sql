
CREATE PROCEDURE [dbo].[usp_GetSystemLog]
    (
     @filters NVARCHAR(MAX),
     @FromDate NVARCHAR(MAX),
     @ToDate NVARCHAR(MAX)
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Query NVARCHAR(MAX)= '
    SELECT
        msg_dt AS Date, 
        product AS Product,
        type AS Status,
        msg_text AS Message
    FROM
        dbo.int_msg_log
    WHERE
        msg_dt 
        BETWEEN ';
    SET @Query = @Query + '''' + @FromDate + '''';
    SET @Query = @Query + ' and ';
    SET @Query = @Query + '''' + @ToDate + '''';
                                        
    IF (LEN(@filters) > 0)
        SET @Query = @Query + ' and ';
    
    SET @Query = @Query + @filters;

    EXEC(@Query);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetSystemLog';

