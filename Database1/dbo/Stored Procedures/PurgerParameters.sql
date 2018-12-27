
CREATE PROCEDURE [dbo].[PurgerParameters]
    (
     @Name VARCHAR(MAX),
     @purgeDate DATETIME OUTPUT,
     @ChunkSize INT OUTPUT
    )
AS
BEGIN
    SET NOCOUNT ON;

    SET @ChunkSize = 200; --Default Chunk Size
    SELECT
        @purgeDate = DATEADD(hh, -CONVERT(INT, (SELECT
                                                    [parm_value]
                                                FROM
                                                    [dbo].[int_system_parameter]
                                                WHERE
                                                    [name] = @Name
                                               ), 111), GETDATE());  

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
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'PurgerParameters';

