

CREATE PROCEDURE [dbo].[p_Node_Results]
    @patient_id UNIQUEIDENTIFIER,
    @min_date DATETIME,
    @max_date DATETIME,
    @node_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @level INT,
        @table VARCHAR(100);

    SET @level = 0;

    SET @table = 'int_result';

    SET NOCOUNT OFF;

    CREATE TABLE [#TMP_NODES]
        (
         [node_id] INT,
         [rank] INT NULL,
         [parent_node_id] INT NULL,
         [node_name] NVARCHAR(100) NULL,
         [level] INT
        );

    IF (@node_id IS NULL)
    BEGIN
        INSERT  INTO [#TMP_NODES]
        SELECT
            [node_id],
            [rank],
            [parent_node_id],
            [node_name],
            @level [LEVEL]
        FROM
            [dbo].[int_test_group]
        WHERE
            [parent_node_id] IS NULL;
    END;
    ELSE
    BEGIN
        INSERT  INTO [#TMP_NODES]
        SELECT
            [node_id],
            [rank],
            [parent_node_id],
            [node_name],
            @level [LEVEL]
        FROM
            [dbo].[int_test_group]
        WHERE
            [node_id] = @node_id;
    END;

    WHILE (@@ROWCOUNT <> 0)
    BEGIN
        SET @level = @level + 1;

        INSERT  INTO [#TMP_NODES]
        SELECT
            [node_id],
            [rank],
            [parent_node_id],
            [node_name],
            @level
        FROM
            [dbo].[int_test_group]
        WHERE
            [parent_node_id] IN (SELECT
                                [node_id]
                               FROM
                                [#TMP_NODES])
            AND [node_id] NOT IN (SELECT
                                    [node_id]
                                FROM
                                    [#TMP_NODES]);
    END;

  /*
  select * from int_result
  where patient_id = @patient_id
  and    obs_start_dt <= @max_date
  and    obs_start_dt >= @min_date
  and   ((is_history is null) or (is_history = 0))
  */

    SELECT
        [#TMP_NODES].[rank] [NODERANK],
        [#TMP_NODES].[node_id],
        [#TMP_NODES].[node_name],
        [alias_test_cid] [ALIAS],
        [int_test_group_detail].[source_cid] [TGD_SOURCE_CID],
        [int_test_group_detail].[rank] [DETRANK],
        [nm],
        [display_type],
        'rtTest' [TEST_TYPE],
        [sys_id],
        [obs_start_dt],
        [order_id],
        [int_result].[univ_svc_cid],
        [int_result].[test_cid],
        [history_seq],
        [test_sub_id],
        [order_line_seq_no],
        [test_result_seq_no],
        [result_dt],
        [value_type_cd],
        [specimen_id],
        [int_result].[source_cid],
        [status_cid],
        [result_units_cid],
        [reference_range_id],
        [abnormal_cd],
        [nsurv_tfr_ind],
        [prin_rslt_intpr_id],
        [result_value],
        CONVERT (VARCHAR(10), [result_comment]) [RESULT_COMMENT]
    INTO
        [#TMP_RESULTS]
    FROM
        [#TMP_NODES],
        [dbo].[int_test_group_detail],
        [dbo].[int_result],
        [dbo].[int_misc_code]
    WHERE
        [patient_id] = @patient_id
        AND [obs_start_dt] <= @max_date
        AND [obs_start_dt] >= @min_date
        AND (([is_history] IS NULL)
        OR ([is_history] = 0)
        )
        AND [#TMP_NODES].[node_id] = [int_test_group_detail].[node_id]
        AND [int_test_group_detail].[test_cid] = [int_result].[test_cid]
        AND [int_result].[test_cid] = [code_id]
    UNION
    SELECT DISTINCT
        [#TMP_NODES].[rank] [NODERANK],
        [#TMP_NODES].[node_id],
        [#TMP_NODES].[node_name],
        [alias_univ_svc_cid] [ALIAS],
        [int_test_group_detail].[source_cid] [TGD_SOURCE_CID],
        [int_test_group_detail].[rank] [DETRANK],
        [nm],
        [display_type],
        'rtUsid' [TEST_TYPE],
        [sys_id],
        [obs_start_dt],
        [order_id],
        [int_result].[univ_svc_cid],
        NULL [TEST_CID],
        [history_seq],
        NULL [TEST_SUB_ID],
        [order_line_seq_no],
        NULL [TEST_RESULT_SEQ_NO],
        [result_dt],
        NULL [VALUE_TYPE_CD],
        [specimen_id],
        [int_result].[source_cid],
        NULL [STATUS_CID],
        NULL [RESULT_UNITS_CID],
        NULL [REFERENCE_RANGE_ID],
        [abnormal_cd],
        [nsurv_tfr_ind],
        [prin_rslt_intpr_id],
        NULL [RESULT_VALUE],
        CONVERT(VARCHAR(10), [result_comment]) [RESULT_COMMENT]
    FROM
        [#TMP_NODES],
        [dbo].[int_test_group_detail],
        [dbo].[int_result],
        [dbo].[int_misc_code]
    WHERE
        [patient_id] = @patient_id
        AND [obs_start_dt] <= @max_date
        AND [obs_start_dt] >= @min_date
        AND (([is_history] IS NULL)
        OR ([is_history] = 0)
        )
        AND [#TMP_NODES].[node_id] = [int_test_group_detail].[node_id]
        AND [int_test_group_detail].[univ_svc_cid] = [int_result].[univ_svc_cid]
        AND [int_result].[univ_svc_cid] = [code_id];

    SELECT DISTINCT
        [int_patient_image].[order_id],
        1 [HAS_IMAGE]
    INTO
        [#TMP_IMAGES]
    FROM
        [#TMP_RESULTS],
        [dbo].[int_patient_image]
    WHERE
        [#TMP_RESULTS].[order_id] = [int_patient_image].[order_id]
        AND [patient_id] = @patient_id;

    SELECT
        [#TMP_RESULTS].[NODERANK],
        [#TMP_RESULTS].[node_id],
        [#TMP_RESULTS].[node_name],
        [#TMP_RESULTS].[ALIAS],
        [#TMP_RESULTS].[TGD_SOURCE_CID],
        [#TMP_RESULTS].[DETRANK],
        [#TMP_RESULTS].[nm],
        [#TMP_RESULTS].[display_type],
        [#TMP_RESULTS].[TEST_TYPE],
        [#TMP_RESULTS].[sys_id],
        [#TMP_RESULTS].[obs_start_dt],
        [#TMP_RESULTS].[order_id],
        [#TMP_RESULTS].[univ_svc_cid],
        [#TMP_RESULTS].[test_cid],
        [#TMP_RESULTS].[history_seq],
        [#TMP_RESULTS].[test_sub_id],
        [#TMP_RESULTS].[order_line_seq_no],
        [#TMP_RESULTS].[test_result_seq_no],
        [#TMP_RESULTS].[result_dt],
        [#TMP_RESULTS].[value_type_cd],
        [#TMP_RESULTS].[specimen_id],
        [#TMP_RESULTS].[source_cid],
        [#TMP_RESULTS].[status_cid],
        [#TMP_RESULTS].[result_units_cid],
        [#TMP_RESULTS].[reference_range_id],
        [#TMP_RESULTS].[abnormal_cd],
        [#TMP_RESULTS].[nsurv_tfr_ind],
        [#TMP_RESULTS].[prin_rslt_intpr_id],
        [#TMP_RESULTS].[result_value],
        [#TMP_RESULTS].[RESULT_COMMENT],
        [M1].[code] [SOURCE_CD],
        [RR].[reference_range],
        [PN].[last_nm],
        [PN].[first_nm],
        [PN].[middle_nm],
        [PN].[suffix],
        [int_order].[status_cid] [ORDER_STATUS_CID],
        [HAS_IMAGE],
        [encounter_id]
    FROM
        [#TMP_RESULTS]
        LEFT OUTER JOIN [dbo].[int_reference_range] [RR] ON ([#TMP_RESULTS].[reference_range_id] = [RR].[reference_range_id])
        LEFT OUTER JOIN [dbo].[int_misc_code] [M1] ON ([#TMP_RESULTS].[source_cid] = [M1].[code_id])
        LEFT OUTER JOIN [dbo].[int_person_name] [PN] ON ([#TMP_RESULTS].[prin_rslt_intpr_id] = [PN].[person_nm_id])
        LEFT OUTER JOIN [dbo].[int_order] ON ([#TMP_RESULTS].[order_id] = [int_order].[order_id])
        LEFT OUTER JOIN [#TMP_IMAGES] ON ([#TMP_RESULTS].[order_id] = [#TMP_IMAGES].[order_id]);

    DROP TABLE [#TMP_NODES];

    DROP TABLE [#TMP_RESULTS];

    DROP TABLE [#TMP_IMAGES];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Node_Results';

