﻿
CREATE PROCEDURE [dbo].[p_Purge_Set_Task]
  (
  @TaskName NVARCHAR(30),
  @TaskVal  NVARCHAR(30)
  )
AS
  BEGIN
    UPDATE int_system_parameter
    SET    parm_value = @TaskVal
    WHERE  ( name = @TaskName )
  END

