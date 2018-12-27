
-- [AddResults_Dm3] is used to Add or Update Encounter Table values in DM3 Loader
CREATE PROCEDURE [dbo].[usp_DM3_AddResults]
    (
     @ResultGUID NVARCHAR(50) = NULL,
     @PatientGUID NVARCHAR(50) = NULL,
     @OrderIDGUID NVARCHAR(50) = NULL,
     @Result_usid NVARCHAR(50) = NULL,
     @Test_cid NVARCHAR(50) = NULL,
     @BTime NVARCHAR(50) = NULL,
     @BFileTime NVARCHAR(50) = NULL,
     @ResultVal NVARCHAR(50) = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[int_result]
            ([result_id],
             [patient_id],
             [order_id],
             [univ_svc_cid],
             [test_cid],
             [obs_start_dt],
             [result_dt],
             [result_ft],
             [value_type_cd],
             [result_value],
             [mod_dt],
             [has_history],
             [is_history],
             [monitor_sw]
            )
    VALUES
            (@ResultGUID,
             @PatientGUID,
             @OrderIDGUID,
             @Result_usid,
             @Test_cid,
             @BTime,
             @BTime,
             @BFileTime,
             'NM',
             @ResultVal,
             @BTime,
             0,
             0,
             '1'
            );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Add or Update Encounter Table values in DM3 Loader.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DM3_AddResults';

