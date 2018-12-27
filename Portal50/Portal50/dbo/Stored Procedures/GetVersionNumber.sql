
CREATE PROCEDURE [GetVersionNumber]
AS
  BEGIN
    SELECT TOP(1) ver_code AS VERSION,
                  install_dt AS DT
    FROM   int_db_ver
    ORDER  BY install_dt DESC
  END

