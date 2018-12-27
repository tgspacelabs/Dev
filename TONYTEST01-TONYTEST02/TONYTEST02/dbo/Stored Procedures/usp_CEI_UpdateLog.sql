CREATE PROCEDURE [dbo].[usp_CEI_UpdateLog]
(
@status int,
@description NVARCHAR(300),
@eventId UNIQUEIDENTIFIER,
@seqNum int,
@client NVARCHAR(50)
)
as
begin
UPDATE [dbo].[int_event_log]
   SET 
   status=@status,
	   description=@description
	   where
       event_id=@eventId and 
       seq_num=@seqNum and
       client=@client
   
end


-----------Inline Queries from CA

