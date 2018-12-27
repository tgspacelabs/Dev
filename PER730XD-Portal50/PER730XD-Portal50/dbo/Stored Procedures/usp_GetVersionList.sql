create proc [dbo].[usp_GetVersionList]

as
begin
    SELECT ver_code, install_dt, status_cd, install_pgm FROM int_db_ver
end
