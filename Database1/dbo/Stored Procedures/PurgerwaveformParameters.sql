
CREATE PROCEDURE [dbo].[PurgerwaveformParameters]
    (
     @purgeDate DATETIME OUTPUT,
     @ChunkSize INT OUTPUT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NumberOfHours INT= NULL;
	
    SET @NumberOfHours = CONVERT(INT, (SELECT
                                        [setting]
                                       FROM
                                        [dbo].[int_sysgen]
                                       WHERE
                                        [product_cd] = 'fulldiscl'
                                        AND [feature_cd] = 'NUMBER_OF_HOURS'
                                      ), 111);
    IF (@NumberOfHours IS NULL)
    BEGIN
        SELECT
            @purgeDate = DATEADD(hh, -24, GETDATE());  --Default is 24 hrs
    END;
    ELSE
    BEGIN
        SELECT
            @purgeDate = DATEADD(hh, -@NumberOfHours, GETDATE());  
    END;

    SET @ChunkSize = 200;--Default Chunk size is 200
    IF ((SELECT
            [parm_value]
         FROM
            [dbo].[int_system_parameter]
         WHERE
            [active_flag] = 1
            AND [name] = 'ChunkSize'
        ) IS NOT NULL)
        SELECT
            @ChunkSize = [parm_value]
        FROM
            [dbo].[int_system_parameter]
        WHERE
            [active_flag] = 1
            AND [name] = 'ChunkSize';
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'PurgerwaveformParameters';

