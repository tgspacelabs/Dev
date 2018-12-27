
create proc [dbo].[usp_CEI_InsertLog]
      (	   @eventId UNIQUEIDENTIFIER,
           @patientId UNIQUEIDENTIFIER = NULL,
           @type NVARCHAR(30),
           @eventDt datetime,
           @seqNum int,
           @client NVARCHAR(50),
           @description NVARCHAR(300),
           @status int)
           as
           begin


INSERT INTO [dbo].[int_event_log]
           ([event_id]
           ,[patient_id]
           ,[type]
           ,[event_dt]
           ,[seq_num]
           ,[client]
           ,[description]
           ,[status])
     VALUES
           (@eventId
           ,@patientId
           ,@type
           ,@eventDt
           ,@seqNum
           ,@client
           ,@description
           ,@status)
end
