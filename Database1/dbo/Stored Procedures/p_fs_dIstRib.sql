

CREATE PROCEDURE [dbo].[p_fs_dIstRib]
    (
     @patient_id UNIQUEIDENTIFIER,
     @fs_id UNIQUEIDENTIFIER = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [obs_start_dt],
        COUNT(*) [CNT]
    FROM
        [dbo].[int_flowsheet_detail],
        [dbo].[int_result]
    WHERE
        [flowsheet_id] = @fs_id
        AND [int_flowsheet_detail].[test_cid] = [int_result].[test_cid]
        AND (([is_history] = 0)
        OR ([is_history] IS NULL)
        )
        AND [patient_id] = @patient_id
    GROUP BY
        [obs_start_dt]
    ORDER BY
        [obs_start_dt] DESC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_fs_dIstRib';

