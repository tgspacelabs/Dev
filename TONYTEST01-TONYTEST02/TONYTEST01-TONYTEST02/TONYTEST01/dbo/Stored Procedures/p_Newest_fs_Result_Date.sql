
CREATE PROCEDURE [dbo].[p_Newest_fs_Result_Date]
  (
  @patient_id UNIQUEIDENTIFIER,
  @fs_id      UNIQUEIDENTIFIER = NULL
  )
AS
  SELECT Max( obs_start_dt ) MAX_DATE
  FROM   int_flowsheet_detail,
         int_result
  WHERE  flowsheet_id = @fs_id AND int_flowsheet_detail.test_cid = int_result.test_cid AND ( ( is_history = 0 )  OR ( is_history IS NULL ) ) AND patient_id = @patient_id

