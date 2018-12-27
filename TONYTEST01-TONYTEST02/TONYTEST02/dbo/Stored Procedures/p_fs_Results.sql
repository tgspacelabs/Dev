
CREATE PROCEDURE [dbo].[p_fs_Results]
  (
  @patient_id UNIQUEIDENTIFIER,
  @min_date   DATETIME,
  @max_date   DATETIME,
  @fs_id      UNIQUEIDENTIFIER = NULL
  )
AS
  SELECT DISTINCT /*name,*/
         int_result.test_cid,
         obs_start_dt,
         result_value,
         result_id,
         has_history,
         order_id,
         flowsheet_detail_id,
         mod_user_id
  FROM   int_flowsheet_detail,
         int_result
  WHERE  flowsheet_id = @fs_id AND int_flowsheet_detail.test_cid = int_result.test_cid AND ( ( is_history = 0 )  OR ( is_history IS NULL ) ) AND patient_id = @patient_id AND obs_start_dt >= @min_date AND obs_start_dt <= @max_date


