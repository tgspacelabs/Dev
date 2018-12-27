
CREATE FUNCTION [dbo].[fn_vital_Merge]
    (
     @InputStrings [dbo].[VitalValues] READONLY,
     @sDelim VARCHAR(20) = ' '
    )
RETURNS @retArray TABLE
    (
     [idx] SMALLINT PRIMARY KEY,
     [value] VARCHAR(8000)
    )
    WITH SCHEMABINDING
AS
BEGIN
    DECLARE
        @VitalsCombine VARCHAR(MAX) = '',
        @VitalsPatientRowCount INT;

    SELECT
        @VitalsPatientRowCount = COUNT([VitalValue])
    FROM
        @InputStrings;

    WHILE (@VitalsPatientRowCount > 0)
    BEGIN
        IF (@VitalsCombine <> '')
            SET @VitalsCombine += @sDelim + (SELECT
                                                [VitalValue]
                                             FROM
                                                @InputStrings
                                             WHERE
                                                [Id] = @VitalsPatientRowCount
                                            );
        ELSE
            SET @VitalsCombine = (SELECT
                                    [VitalValue]
                                  FROM
                                    @InputStrings
                                  WHERE
                                    [Id] = @VitalsPatientRowCount
                                 );

        SET @VitalsPatientRowCount = @VitalsPatientRowCount - 1;
    END;

    INSERT  INTO @retArray
            ([idx],
             [value]
            )
    SELECT
        [idx],
        [value]
    FROM
        [dbo].[fn_Split](@VitalsCombine, @sDelim);

    RETURN;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'FUNCTION', @level1name = N'fn_vital_Merge';

