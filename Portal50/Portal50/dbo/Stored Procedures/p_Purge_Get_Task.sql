
CREATE PROCEDURE [dbo].[p_Purge_Get_Task]
  (
  @TaskName NVARCHAR(30)
  )
AS
  BEGIN
    SELECT parm_value
    FROM   int_system_parameter
    WHERE  ( name = @TaskName )
  END

