CREATE PROCEDURE [dbo].[usp_GetHL7LogListOutbound]
(
	@FromDate NVARCHAR(MAX),
	@ToDate NVARCHAR(MAX),
	@MessageNumber NVARCHAR(40)=null,
	@patientId NVARCHAR(40)=null,
	@MsgEventCode nchar(6)=null,
	@MsgEventType nchar(6)=null,
	@MsgSystem NVARCHAR(100)=null,
	@MsgStatusRead bit, 
	@MsgStatusError bit,
	@MsgStatusNotProcessed bit
)
AS
BEGIN
DECLARE @Query NVARCHAR(MAX),@SubQuery NVARCHAR(200)
SET  @Query= 
'SELECT 
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
WHERE queued_dt BETWEEN '
SET @Query = @Query + '''' + @FromDate + ''''
SET @Query = @Query +' AND '
SET @Query = @Query + '''' + @ToDate + ''''
if(@MessageNumber IS NOT NULL AND @messageNumber<>'')
	SET @Query = @Query +' AND  msg_no='+''''+@MessageNumber +''''
if(@patientId IS NOT NULL AND @patientId<>'')
	SET @Query = @Query +' AND  patient_id='+''''+@patientId +''''
if(@MsgEventCode IS NOT NULL AND @MsgEventCode<>'')
	SET @Query=@Query +' AND  msh_event_cd='+''''+@MsgEventCode +''''
if(@MsgEventType IS NOT NULL AND @MsgEventType<>'')
	SET @Query=@Query +' AND  msh_msg_type='+''''+@MsgEventType +''''
if(@MsgSystem IS NOT NULL AND @MsgSystem<>'')
	SET @Query=@Query +' AND  msh_system='+''''+@MsgSystem +''''
if(@MsgStatusRead=1 OR @MsgStatusError=1 OR @MsgStatusNotProcessed=1)
BEGIN
SET @Query=@Query + ' AND '
SET @SubQuery='('

IF(@MsgStatusRead=1)
	BEGIN
		SET @SubQuery=@SubQuery +' msg_status=''R'' '
	END
IF(@MsgStatusError=1)
	BEGIN
		if(LEN(@SubQuery)>1) SET @SubQuery=@SubQuery +' OR '
		SET @SubQuery=@SubQuery +' msg_status=''E'' '
	END
IF(@MsgStatusNotProcessed=1)
	BEGIN
		if(LEN(@SubQuery)>1) SET @SubQuery=@SubQuery +' OR '
		SET @SubQuery=@SubQuery +' msg_status=''N'' '
	END
SET @SubQuery=@SubQuery +')'
SET @Query=@Query+@SubQuery
END
EXEC(@Query)
END

