
CREATE PROCEDURE [dbo].[p_enc_det_drs]
  (
  @enc_id UNIQUEIDENTIFIER
  )
AS
  DECLARE
    @min_desc_key INT,
    @att_hcp_id   UNIQUEIDENTIFIER,
    @ref_hcp_id   UNIQUEIDENTIFIER,
    @adm_hcp_id   UNIQUEIDENTIFIER

  CREATE TABLE #ENC_DET_DRS
    (
       hcp_id     UNIQUEIDENTIFIER,
       priority   INT,
       lastname   VARCHAR( 50 ) NULL,
       firstname  VARCHAR( 50 ) NULL,
       middlename VARCHAR( 50 ) NULL,
       role_cd    CHAR( 1 )
    )

  SELECT @att_hcp_id = attend_hcp_id,
         @ref_hcp_id = referring_hcp_id,
         @adm_hcp_id = admit_hcp_id
  FROM   int_encounter
  WHERE  encounter_id = @enc_id

  /* attending */
  IF ( @att_hcp_id IS NOT NULL )
    BEGIN
      INSERT INTO #ENC_DET_DRS
        SELECT @att_hcp_id,
               1,
               H.last_nm,
               H.first_nm,
               H.middle_nm,
               'T'
        FROM   int_hcp H
        WHERE  H.hcp_id = @att_hcp_id
    END

  /* admitting */
  IF ( @adm_hcp_id IS NOT NULL )
    BEGIN
      INSERT INTO #ENC_DET_DRS
        SELECT @adm_hcp_id,
               1,
               H.last_nm,
               H.first_nm,
               H.middle_nm,
               'A'
        FROM   int_hcp H
        WHERE  H.hcp_id = @adm_hcp_id
    END

  /* referring */
  IF ( @ref_hcp_id IS NOT NULL )
    BEGIN
      INSERT INTO #ENC_DET_DRS
        SELECT @ref_hcp_id,
               2,
               H.last_nm,
               H.first_nm,
               H.middle_nm,
               'R'
        FROM   int_hcp H
        WHERE  H.hcp_id = @ref_hcp_id
    END

  /* consulting docs */
  INSERT INTO #ENC_DET_DRS
    SELECT DISTINCT
           ( E.hcp_id ),
           3,
           H.last_nm,
           H.first_nm,
           H.middle_nm,
           E.hcp_role_cd
    FROM   int_encounter_to_hcp_int E,
           int_hcp H
    WHERE  E.encounter_id = @enc_id AND E.hcp_id = H.hcp_id AND E.hcp_role_cd = 'C'

  /* select out data */
  SELECT role_cd,
         lastname,
         firstname,
         middlename
  FROM   #ENC_DET_DRS
  ORDER  BY priority,lastname

  DROP TABLE #ENC_DET_DRS


