
CREATE PROCEDURE [dbo].[sp_Table_Sizes]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @tname VARCHAR(100),
        @sql VARCHAR(100);
 
    DECLARE [TCURSOR] CURSOR LOCAL STATIC FORWARD_ONLY
    FOR
    SELECT
        [name]
    FROM
        [sys].[sysobjects]
    WHERE
        [name] LIKE 'int_%';

    OPEN [TCURSOR];

    FETCH NEXT FROM [TCURSOR] INTO @tname;

    WHILE (@@FETCH_STATUS = 0)
    BEGIN
        EXEC [sys].[sp_spaceused] @tname;

        FETCH NEXT FROM [TCURSOR] INTO @tname;
    END;

    CLOSE [TCURSOR];

    DEALLOCATE [TCURSOR];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'sp_Table_Sizes';

