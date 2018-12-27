CREATE PROCEDURE [dbo].[usp_InsertSendSysDetails]
(
@sys_id UNIQUEIDENTIFIER,
@organization_id UNIQUEIDENTIFIER,
@code NVARCHAR(30),
@dsc NVARCHAR(80)
)
as
begin
	INSERT INTO 
                                                    int_send_sys 
                                                    (
                                                    sys_id,
                                                    organization_id, 
                                                    code, 
                                                    dsc
                                                    )
                                                    VALUES
                                                    (
                                                    @sys_id,
                                                    @organization_id,
                                                    @code,
                                                    @dsc
                                                    )
end

