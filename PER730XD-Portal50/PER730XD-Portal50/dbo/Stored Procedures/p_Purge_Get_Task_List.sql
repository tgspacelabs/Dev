
/* Task List */
CREATE PROCEDURE [dbo].[p_Purge_Get_Task_List]
AS
  BEGIN
    SELECT name,
           parm_value,
           debug_sw
    FROM   int_system_parameter
    WHERE  active_flag = 1
    ORDER  BY system_parameter_id
  END

