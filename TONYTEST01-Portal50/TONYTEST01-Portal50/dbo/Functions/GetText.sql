
CREATE FUNCTION [dbo].[GetText]
  (
  @text_id UNIQUEIDENTIFIER
  )
RETURNS VARCHAR( 8000 )
AS
  BEGIN
    DECLARE
      @txt   VARCHAR(8000),
      @cnt   INT,
      @small VARCHAR(8000),
      @large VARCHAR(8000),
      @line  VARCHAR(8000)

    IF ( @text_id IS NULL )
      BEGIN
        SET @txt = NULL
      END

    IF ( @text_id IS NOT NULL )
      BEGIN
        SELECT @cnt = COUNT(*)
        FROM   int_text
        WHERE  text_id = @text_id

        IF ( @cnt <= 1 )
          BEGIN
            SELECT @small = small_text,
                   @large = large_text
            FROM   int_text
            WHERE  text_id = @text_id

            SET @line = @small

            IF ( @line IS NULL )
              SET @line = @large

            SET @txt = @line
          END

        IF ( @cnt > 1 )
          BEGIN
            DECLARE TCURSOR CURSOR FOR
              SELECT small_text,
                     large_text
              FROM   int_text
              WHERE  text_id = @text_id
              ORDER  BY seq_no

            OPEN TCURSOR

            FETCH NEXT FROM TCURSOR INTO @small, @large

            WHILE ( @@FETCH_STATUS = 0 )
              BEGIN
                SET @line = @small

                IF ( @line IS NULL )
                  SET @line = @large

                IF ( @line IS NOT NULL )
                  BEGIN
                    SET @line = RTRIM( @line )

                    IF ( @txt IS NOT NULL )
                      SET @txt = @txt + CHAR(13) + CHAR(10) + @line
                    ELSE
                      SET @txt = @line
                  END

                FETCH NEXT FROM TCURSOR INTO @small, @large
              END /* while */
          END /* if */

      END /* if text_id is not null */

    CLOSE TCURSOR

    DEALLOCATE TCURSOR

    RETURN @txt

  END

