create proc [dbo].[usp_GetHL7LogOutQueue]
(
@msg_no char(20)
)
as
begin
    SELECT 
                                                    ISNULL(hl7_text_short, hl7_text_long) AS Message 
                                                    FROM
                                                    hl7_out_queue 
                                                    WHERE
                                                    msg_no =@msg_no
end
