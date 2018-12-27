﻿CREATE PROCEDURE [dbo].[usp_GetGatewayDetailsByCategoryAndMethod]
as
begin
	select * 
            from 
            int_misc_code 
            where 
            category_cd = 'USID' 
            and 
            method_cd = 'GDS' 
            order by 
            code
end

