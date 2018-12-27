
CREATE PROCEDURE [dbo].[p_cb_Load_History]
  (
  @TestCid    INT,
  @ObsStartDt DATETIME,
  @PatientId  UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT *
    FROM   int_result
           LEFT OUTER JOIN int_user
             ON ( int_result.mod_user_id = int_user.user_id )
    WHERE  test_cid = @TestCid AND obs_start_dt = @ObsStartDt AND patient_id = @PatientId
    ORDER  BY mod_dt DESC
  END


