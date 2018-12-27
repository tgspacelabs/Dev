
CREATE Procedure [dbo].[PurgerParameters]
(
    @Name varchar(max),
    @purgeDate DateTime OUTPUT,
    @ChunkSize INT OUTPUT
)
AS
BEGIN

SET @ChunkSize=200 --Default Chunk Size
SELECT @purgeDate = DATEADD(hh, -CONVERT(INT, (SELECT parm_value FROM int_system_parameter WHERE name=@Name),111),GETDATE())  

IF ((SELECT parm_value  FROM  int_system_parameter WHERE  active_flag = 1 and name='ChunkSize') IS NOT NULL)
SELECT  @ChunkSize= parm_value  FROM  int_system_parameter WHERE  active_flag = 1 and name='ChunkSize'

END
