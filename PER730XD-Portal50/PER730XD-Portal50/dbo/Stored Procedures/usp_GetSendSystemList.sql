create proc [dbo].[usp_GetSendSystemList]
(
@organization_id NVARCHAR(MAX)=null
)
as
begin
DECLARE @Query NVARCHAR(MAX)='
                            SELECT 
                            code,
                            dsc,
                            sys_id 
                            FROM 
                            int_send_sys ' 
                                                       
DECLARE    @Query1 NVARCHAR(MAX)=' ORDER BY code'
    
    if(len(@organization_id)>0)
                begin
                    set @Query = @Query+ ' WHERE organization_id = '
                    set @Query = @Query+ '''' + @organization_id + ''''
                    set @Query = @Query+@Query1
                            
                end                                                    
                
    else
                begin
                    set @Query = @Query+@Query1    
                end                                                                
        exec(@Query)
end

