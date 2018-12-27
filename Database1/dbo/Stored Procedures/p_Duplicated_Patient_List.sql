

CREATE PROCEDURE [dbo].[p_Duplicated_Patient_List]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [duplicate_rec_id],
        [Duplicate_Id] AS [MRN],
        [int_mrn_map].[patient_id]
    INTO
        [#TMP1]
    FROM
        [dbo].[ml_duplicate_info]
        INNER JOIN [dbo].[int_mrn_map] ON ([Duplicate_Id] = [mrn_xid])
        INNER JOIN [dbo].[int_patient_monitor] ON ([int_mrn_map].[patient_id] = [int_patient_monitor].[patient_id])
    WHERE
        ([active_sw] = 1);

    SELECT
        [duplicate_rec_id],
        [Original_ID] AS [MRN],
        [int_mrn_map].[patient_id]
    INTO
        [#TMP2]
    FROM
        [dbo].[ml_duplicate_info]
        INNER JOIN [dbo].[int_mrn_map] ON ([Original_ID] = [mrn_xid])
        INNER JOIN [dbo].[int_patient_monitor] ON ([int_mrn_map].[patient_id] = [int_patient_monitor].[patient_id])
    WHERE
        ([active_sw] = 1);

    SELECT DISTINCT
        [MAP].[patient_id] AS [PATID],
        [MAP].[mrn_xid]
    FROM
        [dbo].[int_mrn_map] [MAP]
        INNER JOIN [dbo].[int_patient_monitor] [MON] ON ([MAP].[patient_id] = [MON].[patient_id])
    WHERE
        [MAP].[mrn_xid] IN (SELECT
                            [DUP].[Original_ID]
                        FROM
                            [dbo].[ml_duplicate_info] [DUP]
                        WHERE
                            [DUP].[duplicate_rec_id] IN (SELECT
                                                        [#TMP1].[duplicate_rec_id]
                                                     FROM
                                                        [#TMP1]
                                                        INNER JOIN [#TMP2] ON ([#TMP1].[duplicate_rec_id] = [#TMP2].[duplicate_rec_id])))
        OR [MAP].[mrn_xid] IN (SELECT
                            [DUP].[Duplicate_Id]
                           FROM
                            [dbo].[ml_duplicate_info] [DUP]
                           WHERE
                            [DUP].[duplicate_rec_id] IN (SELECT
                                                        [#TMP1].[duplicate_rec_id]
                                                     FROM
                                                        [#TMP1]
                                                        INNER JOIN [#TMP2] ON ([#TMP1].[duplicate_rec_id] = [#TMP2].[duplicate_rec_id])))
        AND ([MON].[active_sw] = 1);

    DROP TABLE [#TMP1];

    DROP TABLE [#TMP2];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Duplicated_Patient_List';

