
CREATE PROCEDURE [dbo].[p_Load_fs_Detail]
    (
     @flowsheetID UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [ifd].[flowsheet_detail_id],
        [ifd].[flowsheet_id],
        [ifd].[name],
        [ifd].[detail_type],
        [ifd].[parent_id],
        [ifd].[seq],
        [ifd].[test_cid],
        [ifd].[show_only_when_data],
        [ifd].[is_compressed],
        [ifd].[is_visible],
        [ifd].[flowsheet_entry_id],
        [ife].[flowsheet_entry_id],
        [ife].[test_cid],
        [ife].[data_type],
        [ife].[select_list_id],
        [ife].[units],
        [ife].[normal_float],
        [ife].[absolute_float_high],
        [ife].[absolute_float_low],
        [ife].[warning_float_high],
        [ife].[warning_float_low],
        [ife].[critical_float_high],
        [ife].[critical_float_low],
        [ife].[normal_int],
        [ife].[absolute_int_high],
        [ife].[absolute_int_low],
        [ife].[warning_int_high],
        [ife].[warning_int_low],
        [ife].[critical_int_high],
        [ife].[critical_int_low],
        [ife].[normal_string],
        [ife].[max_length],
        [imc].[code],
        [imc].[short_dsc]
    FROM
        [dbo].[int_flowsheet_detail] AS [ifd]
        LEFT OUTER JOIN [dbo].[int_flowsheet_entry] AS [ife] ON [ifd].[flowsheet_entry_id] = [ife].[flowsheet_entry_id]
        LEFT OUTER JOIN [dbo].[int_misc_code] AS [imc] ON [ifd].[test_cid] = [imc].[code_id]
    WHERE
        [ifd].[flowsheet_id] = @flowsheetID
    ORDER BY
        [ifd].[parent_id],
        [ifd].[seq];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Load_fs_Detail';

