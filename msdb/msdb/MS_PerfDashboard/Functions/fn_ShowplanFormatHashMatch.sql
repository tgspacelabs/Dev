
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatHashMatch(@node_data xml, @logical_op nvarchar(128))
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)
	select @output = N'Hash Match(' + @logical_op

	if (@logical_op = N'Aggregate')
	begin
		if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Hash/sp:HashKeysBuild') = 1)
		begin
			;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
			select @output = @output + N', HASH:(' + MS_PerfDashboard.fn_ShowplanBuildColumnReferenceList(@node_data.query('./sp:Hash/sp:HashKeysBuild/sp:ColumnReference'), 0x1) + N')'
		end
	
		if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Hash/sp:BuildResidual') = 1)
		begin
			;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
			select @output = @output + N', RESIDUAL:(' + MS_PerfDashboard.fn_ShowplanBuildScalarExpression(@node_data.query('./sp:Hash/sp:BuildResidual/*')) + N')'
		end

		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N', DEFINE: (' + MS_PerfDashboard.fn_ShowplanBuildDefinedValuesList(@node_data.query('./sp:Hash/sp:DefinedValues/*')) + N')';
	end
	else
	begin
		if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Hash/sp:HashKeysBuild') = 1)
		begin
			;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
			select @output = @output + N', HASH:(' + 
				MS_PerfDashboard.fn_ShowplanBuildColumnReferenceList(@node_data.query('./sp:Hash/sp:HashKeysBuild/sp:ColumnReference'), 0x1) + 
				N')=(' + 
				MS_PerfDashboard.fn_ShowplanBuildColumnReferenceList(@node_data.query('./sp:Hash/sp:HashKeysProbe/sp:ColumnReference'), 0x1) + N')'
		end
	
		if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Hash/sp:BuildResidual') = 1) or
			(@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Hash/sp:ProbeResidual') = 1)
		begin
			declare @build_residual bit
	
			select @build_residual = 0x0, @output = @output + N', RESIDUAL:('
	
			if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Hash/sp:BuildResidual') = 1)
			begin
				;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
				select @output = @output + MS_PerfDashboard.fn_ShowplanBuildScalarExpression(@node_data.query('./sp:Hash/sp:BuildResidual/*'))
				select @build_residual = 0x1
			end
	
			if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Hash/sp:ProbeResidual') = 1)
			begin
				;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
				select @output = @output + case when @build_residual = 0x1 then N' AND ' else '' end + MS_PerfDashboard.fn_ShowplanBuildScalarExpression(@node_data.query('./sp:Hash/sp:ProbeResidual/*'))
			end

			select @output = @output + N')'
		end
	end

	select @output = @output + N')'

	return @output;
end
