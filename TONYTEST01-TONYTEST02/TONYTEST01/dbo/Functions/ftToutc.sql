
/*
drop function FtToUtc
*/

CREATE FUNCTION [dbo].[ftToutc]
  (
  @FtValue BIGINT
  )
RETURNS DATETIME
AS
  BEGIN
    DECLARE
      @SecondsToAdd  BIGINT,
      @MilliSecToAdd BIGINT,
      @RetVal        DATETIME

    SET @RetVal = NULL
    SET @SecondsToAdd = ( @FtValue - 116444736000000000 ) / 10000000
    SET @MilliSecToAdd = ( @FtValue - 116444736000000000 ) / 10000 - ( @SecondsToAdd * 1000 )

    IF ( @SecondsToAdd >= -2147483648 ) AND ( @SecondsToAdd <= 2147483647 ) AND ( @MilliSecToAdd >= -2147483648 ) AND ( @MilliSecToAdd <= 2147483647 )
      SET @RetVal = DATEADD( MILLISECOND,
                             @MilliSecToAdd,
                             DATEADD( SECOND,
                                      @SecondsToAdd,
                                      Cast( '1970-01-01 00:00:00.000' AS DATETIME ) ) )

    RETURN @RetVal
  END

