

-- [AddpatientOrder_DM3] is used to Add or Update Encounter Table values in DM3 Loader
CREATE PROCEDURE [dbo].[usp_DM3_AddpatientOrder]
    (
     @OrderIDGUID NVARCHAR(50) = NULL,
     @PatientGUID NVARCHAR(50) = NULL,
     @Result_usid NVARCHAR(50) = NULL,
     @EncounterGUID NVARCHAR(50) = NULL,
     @MainOrgGUID NVARCHAR(50) = NULL,
     @SendSysID NVARCHAR(50) = NULL,
     @Guid15 NVARCHAR(50) = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

--BEGIN TRANSACTION
    INSERT  INTO [dbo].[int_order_line]
            ([order_id],
             [seq_no],
             [patient_id],
             [orig_patient_id],
             [status_cid],
             [prov_svc_cid],
             [univ_svc_cid],
             [transport_cid],
             [order_line_comment],
             [clin_info_comment],
             [reason_comment],
             [scheduled_dt],
             [observ_dt],
             [status_chg_dt]
            )
    VALUES
            (@OrderIDGUID,
             1,
             @PatientGUID,
             NULL,
             NULL,
             NULL,
             @Result_usid,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL
            );

    INSERT  INTO [dbo].[int_order]
            ([encounter_id],
             [order_id],
             [patient_id],
             [orig_patient_id],
             [priority_cid],
             [status_cid],
             [univ_svc_cid],
             [order_person_id],
             [order_dt],
             [enter_id],
             [verif_id],
             [transcriber_id],
             [parent_order_id],
             [child_order_sw],
             [order_cntl_cid],
             [history_sw],
             [monitor_sw]
            )
    VALUES
            (@EncounterGUID,
             @OrderIDGUID,
             @PatientGUID,
             NULL,
             NULL,
             NULL,
             @Result_usid,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             '0',
             NULL,
             '0',
             '1'
            );


    INSERT  INTO [dbo].[int_order_map]
            ([order_id],
             [patient_id],
             [orig_patient_id],
             [organization_id],
             [sys_id],
             [order_xid],
             [type_cd],
             [seq_no]
            )
    VALUES
            (@OrderIDGUID,
             @PatientGUID,
             NULL,
             @MainOrgGUID,
             @SendSysID,
             @Guid15,
             'F',
             '1'
            );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Add or Update Encounter Table values in DM3 Loader', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DM3_AddpatientOrder';

