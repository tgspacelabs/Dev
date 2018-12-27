
CREATE PROCEDURE [dbo].[usp_GetHL7LogListOutbound]
    (
     @FromDate NVARCHAR(MAX),
     @ToDate NVARCHAR(MAX),
     @MessageNumber NVARCHAR(40) = NULL,
     @patientId NVARCHAR(40) = NULL,
     @MsgEventCode NCHAR(6) = NULL,
     @MsgEventType NCHAR(6) = NULL,
     @MsgSystem NVARCHAR(100) = NULL,
     @MsgStatusRead BIT,
     @MsgStatusError BIT,
     @MsgStatusNotProcessed BIT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @Query NVARCHAR(MAX),
        @SubQuery NVARCHAR(200);
    SET @Query = 'SELECT 
queued_dt AS Date, 
msg_no AS HL7#, 
patient_id AS ''Patient ID'',
msg_status AS Status,
msh_system AS ''Send System'', 
msh_event_cd AS Event,
ISNULL(hl7_text_short,
hl7_text_long) AS Message,
''O'' AS Direction
FROM hl7_out_queue 
WHERE queued_dt BETWEEN ';
    SET @Query = @Query + '''' + @FromDate + '''';
    SET @Query = @Query + ' AND ';
    SET @Query = @Query + '''' + @ToDate + '''';
    IF (@MessageNumber IS NOT NULL
        AND @MessageNumber <> ''
        )
        SET @Query = @Query + ' AND  msg_no=' + '''' + @MessageNumber + '''';

    IF (@patientId IS NOT NULL
        AND @patientId <> ''
        )
        SET @Query = @Query + ' AND  patient_id=' + '''' + @patientId + '''';

    IF (@MsgEventCode IS NOT NULL
        AND @MsgEventCode <> ''
        )
        SET @Query = @Query + ' AND  msh_event_cd=' + '''' + @MsgEventCode + '''';

    IF (@MsgEventType IS NOT NULL
        AND @MsgEventType <> ''
        )
        SET @Query = @Query + ' AND  msh_msg_type=' + '''' + @MsgEventType + '''';

    IF (@MsgSystem IS NOT NULL
        AND @MsgSystem <> ''
        )
        SET @Query = @Query + ' AND  msh_system=' + '''' + @MsgSystem + '''';

    IF (@MsgStatusRead = 1
        OR @MsgStatusError = 1
        OR @MsgStatusNotProcessed = 1
        )
    BEGIN
        SET @Query = @Query + ' AND ';
        SET @SubQuery = '(';

        IF (@MsgStatusRead = 1)
        BEGIN
            SET @SubQuery = @SubQuery + ' msg_status=''R'' ';
        END;

        IF (@MsgStatusError = 1)
        BEGIN
            IF (LEN(@SubQuery) > 1)
                SET @SubQuery = @SubQuery + ' OR ';
            SET @SubQuery = @SubQuery + ' msg_status=''E'' ';
        END;

        IF (@MsgStatusNotProcessed = 1)
        BEGIN
            IF (LEN(@SubQuery) > 1)
                SET @SubQuery = @SubQuery + ' OR ';
            SET @SubQuery = @SubQuery + ' msg_status=''N'' ';
        END;

        SET @SubQuery = @SubQuery + ')';
        SET @Query = @Query + @SubQuery;
    END;

    EXEC(@Query);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetHL7LogListOutbound';

