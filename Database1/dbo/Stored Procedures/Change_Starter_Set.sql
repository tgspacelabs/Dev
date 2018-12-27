
CREATE PROCEDURE [dbo].[Change_Starter_Set] (@lang_code VARCHAR(5))
AS
BEGIN
    /*************************************************************************************************
    Procedure Name: Change_Starter_Set
            
    Parameters: Language Column ex: fra --French, deu -- German, nld -- Dutch, etc
    Output Parameter: Null
    Purpose: To Change the UI from one Language to other, this procedure is Executed, to update the 
             respective strings in respective columns. If we want to change the language from English 
             to French, then we have to give 'FRA' as the parameter
    Tables Involved: int_misc_code, int_test_group, int_test_group_detail,
                     int_order_group, int_site_link, int_environment and int_starter_set
    Date of  Modification: 30 June 2006
    Modification/Add: For localization of ICS, we need to implement some more strings from int_misc_code 
                      to complete the process. For this we have to included these strings in int_starter_set 
                      table for translation. After translation we have to update the relative strings in  
                      int_misc_code table. This modified procedure updates the relative fields in int_misc_code table.
  
    Modified SQL Injections are Commented in format 
    **************************************************************************************************/

    SET NOCOUNT ON;

    DECLARE @sql VARCHAR(255);

    -- Build an empty temp table */
    SELECT
        [set_type_cd],
        [guid],
        [int_id1],
        [int_id2],
        [int_id3],
        [enu],
        [enu] AS [TO_LANG]
    INTO
        [#TMP_STARTER_SET]
    FROM
        [dbo].[int_starter_set]
    WHERE
        [set_type_cd] = N'FS';

    TRUNCATE TABLE [#TMP_STARTER_SET];

    -- Now fill up temp table, to_lang column contains the value for the language we are going to
    SET @sql = 'SELECT set_type_cd, guid, int_id1, int_id2, int_id3, enu,';

    SET @sql = @sql + @lang_code + ' AS to_lang';

    SET @sql = @sql + '  FROM [dbo].[int_starter_set]';

    INSERT  INTO [#TMP_STARTER_SET]
            EXEC (@sql
            ); -- TG-Why not use sp_executesql??

    -- Now update the tables
    SET NOCOUNT OFF;

    --******* Added on 30 June 2006 for Localization ********
    UPDATE
        [dbo].[int_misc_code]
    SET
        [int_keystone_cd] = [to_lang]
    FROM
        [#TMP_STARTER_SET]
    WHERE
        [set_type_cd] = N'GDS-U'
        AND [code_id] = [int_id1]
        AND [code_id] = [int_id2]
        AND [code_id] = [int_id3];

    UPDATE
        [dbo].[int_misc_code]
    SET
        [short_dsc] = [to_lang]
    FROM
        [#TMP_STARTER_SET]
    WHERE
        [set_type_cd] = N'GDS'
        AND [code_id] = [int_id1]
        AND [code_id] = [int_id2]
        AND [code_id] = [int_id3];

    UPDATE
        [dbo].[int_misc_code]
    SET
        [int_keystone_cd] = [to_lang]
    FROM
        [#TMP_STARTER_SET]
    WHERE
        [set_type_cd] = N'HL7-U'
        AND [code_id] = [int_id1]
        AND [code_id] = [int_id2]
        AND [code_id] = [int_id3];

    UPDATE
        [dbo].[int_misc_code]
    SET
        [short_dsc] = [to_lang]
    FROM
        [#TMP_STARTER_SET]
    WHERE
        [set_type_cd] = N'HL7'
        AND [code_id] = [int_id1]
        AND [code_id] = [int_id2]
        AND [code_id] = [int_id3];

    UPDATE
        [dbo].[int_misc_code]
    SET
        [short_dsc] = [to_lang]
    FROM
        [#TMP_STARTER_SET]
    WHERE
        [set_type_cd] = N'S5N'
        AND [code_id] = [int_id1]
        AND [code_id] = [int_id2]
        AND [code_id] = [int_id3];

    UPDATE
        [dbo].[int_misc_code]
    SET
        [int_keystone_cd] = [to_lang]
    FROM
        [#TMP_STARTER_SET]
    WHERE
        [set_type_cd] = N'S5N-U'
        AND [code_id] = [int_id1]
        AND [code_id] = [int_id2]
        AND [code_id] = [int_id3];

    UPDATE
        [dbo].[int_misc_code]
    SET
        [short_dsc] = [to_lang]
    FROM
        [#TMP_STARTER_SET]
    WHERE
        [set_type_cd] = N'SLOG'
        AND [code_id] = [int_id1]
        AND [code_id] = [int_id2]
        AND [code_id] = [int_id3];

    UPDATE
        [dbo].[int_organization]
    SET
        [organization_nm] = [to_lang]
    FROM
        [#TMP_STARTER_SET]
    WHERE
        [set_type_cd] = N'ORG'
        AND [organization_id] = [guid];

    /* int_test_group */
    UPDATE
        [dbo].[int_test_group]
    SET
        [node_name] = ISNULL([to_lang], '')
    FROM
        [#TMP_STARTER_SET]
    WHERE
        [set_type_cd] = N'TG'
        AND [int_id1] = [node_id];

    /* int_test_group_detail */
    UPDATE
        [dbo].[int_test_group_detail]
    SET
        [nm] = ISNULL([to_lang], '')
    FROM
        [#TMP_STARTER_SET]
    WHERE
        [set_type_cd] = N'TGD'
        AND [int_id1] = [node_id]
        AND ISNULL([int_id2], -999) = ISNULL([univ_svc_cid], -999)
        AND ISNULL([int_id3], -999) = ISNULL([test_cid], -999);

    UPDATE
        [dbo].[int_misc_code]
    SET
        [short_dsc] = ISNULL([to_lang], '')
    FROM
        [#TMP_STARTER_SET]
    WHERE
        [set_type_cd] = N'TGD'
        AND [int_id2] = [code_id]
        AND [int_id3] IS NULL
        AND [category_cd] = 'USID';

    UPDATE
        [dbo].[int_misc_code]
    SET
        [short_dsc] = ISNULL([to_lang], '')
    FROM
        [#TMP_STARTER_SET]
    WHERE
        [set_type_cd] = N'TGD'
        AND [int_id2] IS NULL
        AND [int_id3] = [code_id]
        AND [category_cd] = 'ATST';

    /* order group */
    UPDATE
        [dbo].[int_order_group]
    SET
        [node_name] = ISNULL([to_lang], '')
    FROM
        [#TMP_STARTER_SET]
    WHERE
        [set_type_cd] = N'OG'
        AND [int_id1] = [node_id];

    /* order_group_detail - just update usids */
    UPDATE
        [dbo].[int_misc_code]
    SET
        [short_dsc] = ISNULL([to_lang], '')
    FROM
        [#TMP_STARTER_SET]
    WHERE
        [set_type_cd] = N'OGD'
        AND [int_id1] = [code_id]
        AND [category_cd] = 'USID';

    /* site_link */
    UPDATE
        [dbo].[int_site_link]
    SET
        [group_name] = ISNULL([to_lang], '')
    FROM
        [#TMP_STARTER_SET]
    WHERE
        [set_type_cd] = N'SLG'
        AND [int_id1] = [group_rank];

    UPDATE
        [dbo].[int_site_link]
    SET
        [display_name] = ISNULL([to_lang], '')
    FROM
        [#TMP_STARTER_SET]
    WHERE
        [set_type_cd] = N'SL'
        AND [guid] = [link_id];

    /* environments - int_environment */
    UPDATE
        [dbo].[int_environment]
    SET
        [display_name] = ISNULL([to_lang], '')
    FROM
        [#TMP_STARTER_SET]
    WHERE
        [set_type_cd] = N'EL'
        AND [guid] = [env_id];

    DROP TABLE [#TMP_STARTER_SET];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'Change_Starter_Set';

