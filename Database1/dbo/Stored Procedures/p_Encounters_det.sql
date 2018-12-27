
CREATE PROCEDURE [dbo].[p_Encounters_det]
    (
     @patient_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @acct_no CHAR(40)= 'SEE DETAIL',
        @short_dsc VARCHAR(50)= '',
        @diagnosis VARCHAR(255)= ' ',
        @pat_type VARCHAR(30)= '',
        @pat_class VARCHAR(30)= '';

    SELECT DISTINCT
        [TMP_ACCT_XID] = @acct_no,
        [TMP_ACCT_ID] = [A].[account_id],
        [TMP_ENC_ID] = [A].[encounter_id],
        [TMP_ENC_XID] = [C].[encounter_xid],
        [TMP_PAT_TYPE_ID] = [A].[patient_type_cid],
        [TMP_PAT_TYPE] = @pat_type,
        [TMP_PAT_CLASS_ID] = [A].[patient_class_cid],
        [TMP_PAT_CLASS] = @pat_class,
        [TMP_ADMIT_DT] = [A].[admit_dt],
        [TMP_DISCH_DT] = [A].[discharge_dt],
        [TMP_MED_SRVC_ID] = [A].[med_svc_cid],
        [TMP_MED_SRVC] = SPACE(20),
        [TMP_DIAG_ID] = 0,
        [TMP_DIAGNOSIS] = @diagnosis,
        [TMP_DR_ID] = [A].[attend_hcp_id],
        [TMP_ENC_STATUS_CD] = [A].[status_cd],
        [TMP_DR_LAST_NAME] = [B].[last_nm],
        [TMP_DR_FIRST_NAME] = [B].[first_nm],
        [TMP_DR_MIDDLE_NAME] = [B].[middle_nm],
        [TMP_ENC_MAP_STATUS_CD] = [C].[status_cd],
        [TMP_STAT_ACT_CODE] = [C].[event_cd],
        [TMP_VIP_SW] = [A].[vip_sw],
        [TMP_DEPT_CODE] = SPACE(20),
        [TMP_DEPT_ID] = [A].[unit_org_id],
        [TMP_ROOM] = [A].[rm],
        [TMP_BED] = [A].[bed],
        [TMP_DISPO_CID] = [A].[discharge_dispo_cid]
    INTO
        [#ENCOUNTERS]
    FROM
        [dbo].[int_encounter] AS [A]
        LEFT OUTER JOIN [dbo].[int_hcp] AS [B] ON ([A].[attend_hcp_id] = [B].[hcp_id]),
        [dbo].[int_encounter_map] AS [C]
    WHERE
        @patient_id = [C].[patient_id]
        AND [C].[encounter_id] = [A].[encounter_id]
        AND [C].[status_cd] IN (N'N', N'S', N'C')
        AND ([A].[status_cd] != N'X'
        OR [A].[status_cd] IS NULL
        ); /* filter canceled encounters */

    UPDATE
        [#ENCOUNTERS]
    SET
        [TMP_DIAGNOSIS] = ISNULL([dsc], N' '),
        [TMP_DIAG_ID] = ISNULL([diagnosis_cid], 0)
    FROM
        [#ENCOUNTERS] AS [A],
        [dbo].[int_diagnosis] AS [B]
    WHERE
        [A].[TMP_ENC_ID] = [B].[encounter_id]
        AND [B].[inactive_sw] IS NULL
        AND [B].[seq_no] = (SELECT
                                MAX([B].[seq_no])
                            FROM
                                [#ENCOUNTERS] AS [A],
                                [dbo].[int_diagnosis] AS [B]
                            WHERE
                                [A].[TMP_ENC_ID] = [B].[encounter_id]
                                AND [B].[inactive_sw] IS NULL
                           );

    /* update  each of the records in the temporary table that have an account number and have not been moved or merged */
    UPDATE
        [#ENCOUNTERS]
    SET
        [TMP_ACCT_XID] = [account_xid]
    FROM
        [#ENCOUNTERS]
        INNER JOIN [dbo].[int_encounter] AS [ie] ON [#ENCOUNTERS].[TMP_ENC_ID] = [ie].[encounter_id]
        INNER JOIN [dbo].[int_account] AS [ia] ON [ie].[account_id] = [ia].[account_id]
    WHERE
        [ie].[patient_id] = @patient_id
        AND [ia].[account_xid] IS NOT NULL
        AND [#ENCOUNTERS].[TMP_ENC_MAP_STATUS_CD] != N'N';

    /*update each of the records in the temporary table that do not have an account number and have not been moved or merged */
    UPDATE
        [#ENCOUNTERS]
    SET
        [TMP_ACCT_XID] = '*NOT AVAILABLE*'
    FROM
        [#ENCOUNTERS]
    WHERE
        [#ENCOUNTERS].[TMP_ACCT_XID] = @acct_no
        AND /* SEE DETAIL */ [#ENCOUNTERS].[TMP_ENC_MAP_STATUS_CD] != N'N'
        AND [#ENCOUNTERS].[TMP_ENC_MAP_STATUS_CD] != N'S';

    UPDATE
        [#ENCOUNTERS]
    SET
        [TMP_DIAGNOSIS] = [short_dsc]
    FROM
        [#ENCOUNTERS],
        [dbo].[int_misc_code]
    WHERE
        [#ENCOUNTERS].[TMP_DIAG_ID] = [code_id]
        AND [#ENCOUNTERS].[TMP_DIAG_ID] != 0;

    /* Retrieve patient class and type from misc_code; ignore if short_dsc is NULL */
    UPDATE
        [#ENCOUNTERS]
    SET
        [TMP_PAT_TYPE] = ISNULL([M].[short_dsc], ''),
        [TMP_PAT_CLASS] = ISNULL([M2].[short_dsc], '')
    FROM
        [#ENCOUNTERS]
        LEFT OUTER JOIN [dbo].[int_misc_code] [M] ON [#ENCOUNTERS].[TMP_PAT_TYPE_ID] = [M].[code_id]
        INNER JOIN [dbo].[int_misc_code] [M2] ON [#ENCOUNTERS].[TMP_PAT_CLASS_ID] = [M2].[code_id];

    /* Retrieve medical service from misc_code; ignore if short_dsc is NULL */
    UPDATE
        [#ENCOUNTERS]
    SET
        [TMP_MED_SRVC] = [short_dsc]
    FROM
        [#ENCOUNTERS]
        INNER JOIN [dbo].[int_misc_code] AS [imc] ON [#ENCOUNTERS].[TMP_MED_SRVC_ID] = [imc].[code_id]
    WHERE
        [imc].[short_dsc] IS NOT NULL;

    UPDATE
        [#ENCOUNTERS]
    SET
        [TMP_DEPT_CODE] = [io].[organization_cd]
    FROM
        [dbo].[int_organization] AS [io]
    WHERE
        [TMP_DEPT_ID] = [io].[organization_id];

    /*  data has been built now select out all data */
    SELECT
        [TMP_ACCT_XID],
        [TMP_ENC_ID],
        [TMP_ACCT_ID],
        [TMP_PAT_TYPE],
        [TMP_ADMIT_DT],
        [TMP_DISCH_DT],
        [TMP_MED_SRVC],
        [TMP_DIAGNOSIS],
        [TMP_ENC_STATUS_CD],
        [TMP_DR_ID],
        [TMP_DR_LAST_NAME],
        [TMP_DR_FIRST_NAME],
        [TMP_DR_MIDDLE_NAME],
        [TMP_ENC_MAP_STATUS_CD],
        [TMP_ENC_XID],
        [TMP_STAT_ACT_CODE],
        [TMP_PAT_CLASS],
        [TMP_VIP_SW],
        [TMP_DEPT_CODE],
        [TMP_DEPT_ID],
        [TMP_ROOM],
        [TMP_BED],
        [TMP_DISPO_CID]
    FROM
        [#ENCOUNTERS]
    ORDER BY
        [TMP_ADMIT_DT] DESC;

    DROP TABLE [#ENCOUNTERS];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Encounters_det';

