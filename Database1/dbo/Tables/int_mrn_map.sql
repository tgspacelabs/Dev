CREATE TABLE [dbo].[int_mrn_map] (
    [organization_id]  UNIQUEIDENTIFIER NOT NULL,
    [mrn_xid]          NVARCHAR (30)    NOT NULL,
    [patient_id]       UNIQUEIDENTIFIER NOT NULL,
    [orig_patient_id]  UNIQUEIDENTIFIER NULL,
    [merge_cd]         CHAR (1)         NOT NULL,
    [prior_patient_id] UNIQUEIDENTIFIER NULL,
    [mrn_xid2]         NVARCHAR (30)    NULL,
    [adt_adm_sw]       TINYINT          NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [mrn_map_idx]
    ON [dbo].[int_mrn_map]([mrn_xid] ASC, [organization_id] ASC, [patient_id] ASC, [orig_patient_id] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [mrn_map_ndx1]
    ON [dbo].[int_mrn_map]([patient_id] ASC) WITH (FILLFACTOR = 100);


GO

--DROP TRIGGER [dbo].[trig_mrn_map];
--CREATE TRIGGER [dbo].[trig_mrn_map] ON [dbo].[int_mrn_map]
--DROP TRIGGER [dbo].[tiu_int_mrn_map];
CREATE TRIGGER [dbo].[tiu_int_mrn_map] ON [dbo].[int_mrn_map]
    FOR INSERT, UPDATE
AS
INSERT  INTO [dbo].[PatientSessionsMap]
SELECT
    [PatientSessionId] = [LatestID1Assignment].[PatientSessionId],
    [PatientId] = [Inserted].[patient_id]
FROM
    [inserted]
    INNER JOIN (SELECT
                    [AssignmentSequence].[PatientSessionId],
                    [AssignmentSequence].[ID1]
                FROM
                    (SELECT
                        [PatientSessionId],
                        [ID1],
                        [R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [TimestampUTC] DESC)
                     FROM
                        [dbo].[PatientData]
                    ) AS [AssignmentSequence]
                WHERE
                    [AssignmentSequence].[R] = 1
               ) AS [LatestID1Assignment] ON [LatestID1Assignment].[ID1] = [Inserted].[mrn_xid]
    LEFT OUTER JOIN (SELECT
                        [PatientSessionId],
                        [PatientId],
                        [R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [Sequence] DESC)
                     FROM
                        [dbo].[PatientSessionsMap]
                    ) AS [PatientSessionsMapSequence] ON [PatientSessionsMapSequence].[R] = 1
                                                         AND [PatientSessionsMapSequence].[PatientSessionId] = [LatestID1Assignment].[PatientSessionId]
                                                         AND [PatientSessionsMapSequence].[PatientId] = [Inserted].[patient_id]
WHERE
    [PatientSessionsMapSequence].[PatientSessionId] IS NULL;

GO
-- Description:	Creates the Account Id record for the new patient based on int_mrn_map.mrn_xid2
CREATE TRIGGER [dbo].[tiu_int_mrn_map_UpdateHL7Account] ON [dbo].[int_mrn_map]
--WITH EXECUTE AS CALLER
    FOR INSERT, UPDATE
AS
BEGIN
    DECLARE
        @act_xid NVARCHAR(40),
        @org_guid UNIQUEIDENTIFIER,
        @app_name VARCHAR(35);

    SET @app_name = APP_NAME( );

    SELECT
        @act_xid = [Inserted].[mrn_xid2]
    FROM
        [inserted];

    IF @act_xid = N''
        SET @act_xid = NULL;

    IF (@app_name <> N'.Net SqlClient Data Provider'
        AND @act_xid IS NOT NULL
        )
    BEGIN
        IF NOT EXISTS ( SELECT
                            [account_xid]
                        FROM
                            [inserted]
                            INNER JOIN [dbo].[int_encounter] ON [inserted].[patient_id] = [int_encounter].[patient_id]
                            INNER JOIN [dbo].[int_account] ON [int_encounter].[account_id] = [int_account].[account_id]
                        WHERE
                            [account_xid] = [Inserted].[mrn_xid2]
                            AND [discharge_dt] IS NULL )
        BEGIN            

            SELECT
                @org_guid = [inserted].[organization_id]
            FROM
                [inserted];

  
            /* New Account */
            INSERT  INTO [dbo].[int_account]
                    ([account_id],
                     [organization_id],
                     [account_xid],
                     [account_open_dt]
                    )
            VALUES
                    (NEWID( ),
                     @org_guid,
                     @act_xid,
                     GETDATE( )
                    );
        END;
    END;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is used to uniquely identify a medical record number to a PATIENT. This table allows the tracking of the MRNs assigned to a given PATIENT across time. This table takes an ORGANIZATION, their identifier and maps it into a uniquely generated patient ID (GUID). The assumption is that no matter how many MRN''s a patient is know by, there will only be one patient_id for that patient (especially since the MPI should handle minor inconsistencies with data-entry).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_mrn_map';

