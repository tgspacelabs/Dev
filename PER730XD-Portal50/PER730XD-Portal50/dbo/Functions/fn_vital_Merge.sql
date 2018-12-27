
CREATE FUNCTION [dbo].[fn_vital_Merge](@InputStrings VitalValues READONLY, @sDelim varchar(20) = ' ')
RETURNS @retArray TABLE (idx smallint Primary Key, value varchar(8000))
AS
BEGIN

DECLARE @VitalsCombine varchar(max)
SET @VitalsCombine=''

DECLARE @VitalsPatientRowCount int
SELECT @VitalsPatientRowCount = COUNT(VitalValue) 
FROM @InputStrings;

WHILE(@VitalsPatientRowCount>0)
BEGIN
    IF(@VitalsCombine<>'')
        set @VitalsCombine += @sDelim + (SELECT VitalValue FROM @InputStrings where Id=@VitalsPatientRowCount)
    else
    SET @VitalsCombine=(SELECT VitalValue FROM @InputStrings WHERE Id=@VitalsPatientRowCount)
    SET @VitalsPatientRowCount = @VitalsPatientRowCount -1
END

INSERT INTO @retArray(idx,value)
SELECT idx,value from fn_Split(@VitalsCombine,@sDelim)

RETURN
END
