create proc [dbo].[usp_SaveCfgValues]
(
@keyname varchar(40),
@keyvalue varchar(100)
)
as
begin
    IF NOT EXISTS
                                            (
                                            SELECT 
                                            keyname 
                                            FROM
                                            int_cfg_values
                                            WHERE 
                                            keyname = @keyname
                                            ) 
                                            INSERT INTO 
                                            int_cfg_values
                                            (
                                            keyname, 
                                            keyvalue
                                            ) 
                                            VALUES
                                            (
                                            @keyname,
                                            @keyvalue
                                            ) 
                                            ELSE 
                                            UPDATE 
                                            int_cfg_values
                                            SET 
                                            keyvalue =@keyvalue 
                                            WHERE 
                                            keyname =@keyname
end
