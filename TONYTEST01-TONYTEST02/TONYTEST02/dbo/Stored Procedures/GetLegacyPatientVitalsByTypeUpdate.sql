

--////////////////////////////////////////////////-------------END-----------------
--Dummy view creation for ET - Temp fix for resolving dependencies for smooth installation of the build. 
--Remove / Replace this with actual view when it becomes available.
--////////////////////////////////////////////////

-----------Get vitals data for trends view in CA---------------begin

CREATE PROCEDURE [dbo].[GetLegacyPatientVitalsByTypeUpdate]
  (
  @patient_id    UNIQUEIDENTIFIER,
  @type          INT,
  @seq_num_after BIGINT,
  @dateAfter	 BIGINT 
  )
AS
  BEGIN
    SELECT RESULT.result_value AS VALUE,
           RESULT.obs_start_dt AS RESULT_TIME,
           RESULT.Sequence AS SEQ_NUM,
           RESULT.result_ft AS RESULT_FILE_TIME
    FROM   int_result AS RESULT
           INNER JOIN int_misc_code AS CODE
             ON RESULT.test_cid = CODE.code_id
    WHERE  ( RESULT.patient_id = @patient_id ) AND ( CODE.code_id = @type ) AND ( RESULT.Sequence > @seq_num_after )
    ORDER  BY RESULT_FILE_TIME ASC
  END

