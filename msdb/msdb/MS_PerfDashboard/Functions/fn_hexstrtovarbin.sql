
create function MS_PerfDashboard.fn_hexstrtovarbin(@input varchar(8000)) 
returns varbinary(8000) 
as 
begin 
	declare @result varbinary(8000)

	if @input is not null
	begin
		declare @i int, @l int 

		select @result = 0x, @l = len(@input) / 2, @i = 2 
	
		while @i <= @l 
		begin 
			set @result = @result + 
			cast(cast(case lower(substring(@input, @i*2-1, 1)) 
				when '0' then 0x00 
				when '1' then 0x10 
				when '2' then 0x20 
				when '3' then 0x30 
				when '4' then 0x40 
				when '5' then 0x50 
				when '6' then 0x60 
				when '7' then 0x70 
				when '8' then 0x80 
				when '9' then 0x90 
				when 'a' then 0xa0 
				when 'b' then 0xb0 
				when 'c' then 0xc0 
				when 'd' then 0xd0 
				when 'e' then 0xe0 
				when 'f' then 0xf0 
				end as tinyint) | 
			cast(case lower(substring(@input, @i*2, 1)) 
				when '0' then 0x00 
				when '1' then 0x01 
				when '2' then 0x02 
				when '3' then 0x03 
				when '4' then 0x04 
				when '5' then 0x05 
				when '6' then 0x06 
				when '7' then 0x07 
				when '8' then 0x08 
				when '9' then 0x09 
				when 'a' then 0x0a 
				when 'b' then 0x0b 
				when 'c' then 0x0c 
				when 'd' then 0x0d 
				when 'e' then 0x0e 
				when 'f' then 0x0f 
				end as tinyint) as binary(1)) 
		set @i = @i + 1 
		end 
	end

	return @result 
end 
