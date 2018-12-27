
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatMerge(@node_data xml, @logical_op nvarchar(128))
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @output = N'Merge Join(' + @logical_op + case when @node_data.exist('./sp:Merge[@ManyToMany = 1]') = 1 then N', MANY-TO-MANY'
			else N'' end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Merge/sp:InnerSideJoinColumns') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N', MERGE: (' + MS_PerfDashboard.fn_ShowplanBuildColumnReferenceList(@node_data.query('./sp:Merge/sp:InnerSideJoinColumns/sp:ColumnReference'), 0x1) + N')=(' + MS_PerfDashboard.fn_ShowplanBuildColumnReferenceList(@node_data.query('./sp:Merge/sp:OuterSideJoinColumns/sp:ColumnReference'), 0x1) + N')'
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Merge/sp:Residual') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N', RESIDUAL: (' + MS_PerfDashboard.fn_ShowplanBuildScalarExpression(@node_data.query('./sp:Merge/sp:Residual/*')) + N')'
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Merge/sp:PassThru') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N', PASSTHRU: (' + MS_PerfDashboard.fn_ShowplanBuildScalarExpression(@node_data.query('./sp:Merge/sp:PassThru/*')) + N')'
	end

	select @output = @output + N')'

	return @output;
end
