create procedure MS_PerfDashboard.usp_MissingIndexes @showplan varchar(max)
as
begin
	WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	SELECT 
	index_node.value('(../@Impact)[1]', 'float') as index_impact,
	index_node.query('concat(
				string((./@Database)[1]), 
				".",
				string((./@Schema)[1]),
				".",
				string((./@Table)[1])
			)') as target_object_name,
	replace(convert(nvarchar(max), index_node.query('for $colgroup in ./sp:ColumnGroup,
				$col in $colgroup/sp:Column
				where $colgroup/@Usage = "EQUALITY"
   				return string($col/@Name)')), '] [', '],[') as equality_columns,
	replace(convert(nvarchar(max), index_node.query('for $colgroup in ./sp:ColumnGroup,
				$col in $colgroup/sp:Column
				where $colgroup/@Usage = "INEQUALITY"
   				return string($col/@Name)')), '] [', '],[') as inequality_columns,
	replace(convert(nvarchar(max), index_node.query('for $colgroup in .//sp:ColumnGroup,
				$col in $colgroup/sp:Column
				where $colgroup/@Usage = "INCLUDE"
   				return string($col/@Name)')), '] [', '],[') as included_columns
	from (select convert(xml, @showplan) as xml_showplan) as t
		outer apply t.xml_showplan.nodes('//sp:MissingIndexes/sp:MissingIndexGroup/sp:MissingIndex') as missing_indexes(index_node)
end
