

/*[SP_SaveConfigurationSection] table is used to save Configuration data */
CREATE PROCEDURE [dbo].[usp_SaveConfigurationSection]
    (
     @ApplicationName NVARCHAR(256),
     @SectionName NVARCHAR(256),
     @SectionData XML
    )
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS ( SELECT
                    1
                FROM
                    [dbo].[tbl_ConfigurationData]
                WHERE
                    [ApplicationName] = @ApplicationName
                    AND [SectionName] = @SectionName )
    BEGIN
        UPDATE
            [dbo].[tbl_ConfigurationData]
        SET
            [SectionData] = @SectionData,
            [UpdatedTimeStampUTC] = GETUTCDATE()
        WHERE
            [ApplicationName] = @ApplicationName
            AND [SectionName] = @SectionName;
    END;
    ELSE
    BEGIN
        INSERT  INTO [dbo].[tbl_ConfigurationData]
                ([ApplicationName],
                 [SectionName],
                 [SectionData],
                 [UpdatedTimeStampUTC]
                )
        VALUES
                (@ApplicationName,
                 @SectionName,
                 @SectionData,
                 GETUTCDATE()
                );
    END;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to save Configuration data', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_SaveConfigurationSection';

