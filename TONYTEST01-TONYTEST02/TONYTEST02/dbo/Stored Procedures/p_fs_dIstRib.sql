
CREATE PROCEDURE [dbo].[p_fs_dIstRib]
  (
  @patient_id UNIQUEIDENTIFIER,
  @fs_id      UNIQUEIDENTIFIER = NULL
  )
AS
  SELECT obs_start_dt,
         COUNT(*) CNT
  FROM   int_flowsheet_detail,
         int_result
  WHERE  flowsheet_id = @fs_id AND int_flowsheet_detail.test_cid = int_result.test_cid AND ( ( is_history = 0 )  OR ( is_history IS NULL ) ) AND patient_id = @patient_id
  GROUP  BY obs_start_dt
  ORDER  BY obs_start_dt DESC


