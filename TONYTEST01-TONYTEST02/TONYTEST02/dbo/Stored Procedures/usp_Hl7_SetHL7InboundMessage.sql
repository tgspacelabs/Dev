

/*usp_Hl7_SetHL7InQueueInformation used to update Hl7INQUEUE*/
CREATE PROCEDURE [dbo].[usp_Hl7_SetHL7InboundMessage]
(
@MsgNo int,
@PidMrn  NVARCHAR(40)=null,
@Pv1VisitNo NVARCHAR(100)=null,
@MsgStatus nchar(2)=null,
@ProcessedDt datetime=null
)
AS
BEGIN

IF @ProcessedDt IS NULL SET @ProcessedDt=GETDATE();

UPDATE hl7_in_queue
SET pid_mrn=ISNULL(@PidMrn,pid_mrn),
pv1_visit_no=ISNULL(@Pv1VisitNo,pv1_visit_no),
msg_status=ISNULL(@MsgStatus,msg_status),
processed_dt=@ProcessedDt
WHERE msg_no=@MsgNo

END

