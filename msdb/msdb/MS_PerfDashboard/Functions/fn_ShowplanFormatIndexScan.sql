
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatIndexScan(@node_data xml, @physical_op nvarchar(128))
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)	

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @output = @physical_op + N'(OBJECT: (' + MS_PerfDashboard.fn_ShowplanBuildObject(@node_data.query('./sp:IndexScan/sp:Object')) + N')'
	
	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:IndexScan/sp:SeekPredicates/sp:SeekPredicate') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N', SEEK: (' + MS_PerfDashboard.fn_ShowplanBuildSeekPredicates(@node_data.query('./sp:IndexScan/sp:SeekPredicates')) + N')'
	end
	else if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:IndexScan/sp:SeekPredicates/sp:SeekPredicateNew') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N', SEEK: (' + MS_PerfDashboard.fn_ShowplanBuildSeekPredicatesNew(@node_data.query('./sp:IndexScan/sp:SeekPredicates')) + N')'
	end


	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:IndexScan/sp:Predicate') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N', WHERE: (' + MS_PerfDashboard.fn_ShowplanBuildScalarExpression(@node_data.query('./sp:IndexScan/sp:Predicate/*')) + N')'
	end

	select @output = @output + N')'


	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:IndexScan[@Lookup = 1]') = 1)
	begin
		select @output = @output + N' LOOKUP'
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:IndexScan[@Ordered = 1]') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N' ORDERED ' + ISNULL(@node_data.value('(./sp:IndexScan/@ScanDirection)[1]', 'nvarchar(128)'), '')
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:IndexScan[@ForcedIndex = 1]') = 1)
	begin
		select @output = @output + N' FORCEDINDEX'
	end

	return @output;
end
