
/* Waveform Hours */
CREATE PROCEDURE [dbo].[p_Purge_Get_wf_Hours]
AS
  BEGIN
    SELECT setting
    FROM   int_sysgen
    WHERE  product_cd = 'fulldiscl' AND feature_cd = 'NUMBER_OF_HOURS'
  END

