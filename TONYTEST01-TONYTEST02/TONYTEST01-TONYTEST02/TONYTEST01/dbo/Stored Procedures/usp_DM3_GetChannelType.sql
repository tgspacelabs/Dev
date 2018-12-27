CREATE PROCEDURE [dbo].[usp_DM3_GetChannelType]
 AS
 BEGIN
 select channel_type_id, channel_code, label from int_channel_type
 END
