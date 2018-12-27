CREATE proc [dbo].[usp_GetSystemLog]
(
@filters NVARCHAR(MAX),
@FromDate NVARCHAR(MAX),
@ToDate NVARCHAR(MAX)
)
as
begin
declare @Query  NVARCHAR(MAX)='SELECT
                                                msg_dt AS Date, 
                                                product AS Product,
                                                type AS Status,
                                                msg_text AS Message
                                                FROM
                                                int_msg_log
                                                WHERE
                                                msg_dt 
                                                    BETWEEN '
                                                    set @Query = @Query + '''' + @FromDate + ''''
                                                    set @Query = @Query +' and '
                                                    set @Query = @Query + '''' + @ToDate + ''''
                                        
                                         if(len(@filters) > 0 )
                                                            set @Query = @Query + ' and '
                                                            set @Query = @Query + @filters
                                                            exec(@Query)
end
