

CREATE PROCEDURE [dbo].[p_Newest_fs_Result_Date]
    (
     @patient_id UNIQUEIDENTIFIER,
     @fs_id UNIQUEIDENTIFIER = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        MAX([obs_start_dt]) [MAX_DATE]
    FROM
        [dbo].[int_flowsheet_detail],
        [dbo].[int_result]
    WHERE
        [flowsheet_id] = @fs_id
        AND [int_flowsheet_detail].[test_cid] = [int_result].[test_cid]
        AND (([is_history] = 0)
        OR ([is_history] IS NULL)
        )
        AND [patient_id] = @patient_id;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Newest_fs_Result_Date';

