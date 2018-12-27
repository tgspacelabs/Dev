
CREATE PROCEDURE [dbo].[p_Set_lAng] (@ICSLang NVARCHAR(10))
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS ( SELECT
                        [keyvalue]
                    FROM
                        [dbo].[int_cfg_values]
                    WHERE
                        [keyname] = 'Language' )
    BEGIN
        INSERT  INTO [dbo].[int_cfg_values]
        VALUES
                ('Language', @ICSLang);
    END;
    ELSE
        UPDATE
            [dbo].[int_cfg_values]
        SET
            [keyvalue] = @ICSLang
        WHERE
            ([keyname] = 'Language');
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Set_lAng';

