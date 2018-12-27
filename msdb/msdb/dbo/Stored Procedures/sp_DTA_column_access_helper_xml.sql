﻿create procedure sp_DTA_column_access_helper_xml
			@SessionID		int
as
begin
		select 1            as Tag, 
		NULL          as Parent,
		'' as [ColumnAccessReport!1!!ELEMENT],
		NULL as [Database!2!DatabaseID!hide],
		NULL  as [Database!2!Name!ELEMENT] ,
		NULL  as [Schema!3!Name!ELEMENT] ,
		NULL as [Table!4!TableID!hide],
		NULL as [Table!4!Name!ELEMENT],
		NULL as [Column!5!ColumnID!hide],
		NULL as [Column!5!Name!ELEMENT],
		NULL as [Column!5!NumberOfReferences!ELEMENT],
		NULL as [Column!5!PercentUsage!ELEMENT]
	union all
	select 2 as Tag, 1 as Parent, NULL,
			D.DatabaseID,D.DatabaseName,
			NULL,NULL,NULL,NULL,NULL,NULL,NULL
	from [msdb].[dbo].[DTA_reports_database] as D
	where
	D.SessionID = @SessionID and
	D.DatabaseID in
	(select D.DatabaseID from
			[msdb].[dbo].[DTA_reports_querycolumn] as QC,
			[msdb].[dbo].[DTA_reports_column] as C,
			[msdb].[dbo].[DTA_reports_table] as T,
			[msdb].[dbo].[DTA_reports_database] as D
			where
			QC.ColumnID = C.ColumnID  and
			C.TableID = T.TableID and
			T.DatabaseID = D.DatabaseID and
			D.SessionID = @SessionID
			group by D.DatabaseID)
	union all
	select 3 as Tag, 2 as Parent, NULL,
			R.DatabaseID,D.DatabaseName,
			R.SchemaName,NULL,NULL,NULL,NULL,NULL,NULL
	from [msdb].[dbo].[DTA_reports_database] as D,
	(
		select D.DatabaseID,T.SchemaName from
		[msdb].[dbo].[DTA_reports_querycolumn] as QC,
		[msdb].[dbo].[DTA_reports_column] as C,
		[msdb].[dbo].[DTA_reports_table] as T,
		[msdb].[dbo].[DTA_reports_database] as D
		where
		QC.ColumnID = C.ColumnID  and
		C.TableID = T.TableID and
		T.DatabaseID = D.DatabaseID and
		D.SessionID = @SessionID
		group by D.DatabaseID,T.SchemaName
) R

	where
	D.SessionID = @SessionID and
	D.DatabaseID = R.DatabaseID
	union all
	select 4 as Tag, 3 as Parent, NULL,
			R.DatabaseID,D.DatabaseName,
			R.SchemaName,R.TableID,T.TableName,NULL,NULL,NULL,NULL
	from [msdb].[dbo].[DTA_reports_database] as D,
	 [msdb].[dbo].[DTA_reports_table] as T,
	(
		select D.DatabaseID,T.SchemaName,T.TableID from
		[msdb].[dbo].[DTA_reports_querycolumn] as QC,
		[msdb].[dbo].[DTA_reports_column] as C,
		[msdb].[dbo].[DTA_reports_table] as T,
		[msdb].[dbo].[DTA_reports_database] as D
		where
		QC.ColumnID = C.ColumnID  and
		C.TableID = T.TableID and
		T.DatabaseID = D.DatabaseID and
		D.SessionID = @SessionID
		group by D.DatabaseID,T.SchemaName,T.TableID
) R

	where
	D.SessionID = @SessionID and
	D.DatabaseID = R.DatabaseID and
	R.TableID = T.TableID and
	T.DatabaseID = D.DatabaseID

	union all
	select 5 as Tag, 4 as Parent, NULL,
			D1.DatabaseID,D1.DatabaseName,
			T1.SchemaName,T1.TableID,T1.TableName,C1.ColumnID,C1.ColumnName,
			R.Count,
			CAST(R.Usage as decimal(38,2))
	from 
	[msdb].[dbo].[DTA_reports_database]as D1 ,
	[msdb].[dbo].[DTA_reports_table] as T1,
	[msdb].[dbo].[DTA_reports_column] as C1,
	(
		select 	D.DatabaseID,T.TableID,C.ColumnID,
			SUM(Q.Weight) as Count,
			100.0 *  SUM(Q.Weight) / 
			( 1.0 * (	select	CASE WHEN SUM(Q.Weight) > 0 THEN  SUM(Q.Weight)
					else 1
					end	
					from [msdb].[dbo].[DTA_reports_query] as Q
					where Q.SessionID = @SessionID )) as Usage
		from 
			[msdb].[dbo].[DTA_reports_column] as C
			LEFT OUTER JOIN
			[msdb].[dbo].[DTA_reports_querycolumn] as QC ON QC.ColumnID = C.ColumnID
			LEFT OUTER JOIN
			[msdb].[dbo].[DTA_reports_query] as Q ON QC.QueryID = Q.QueryID
			JOIN
			[msdb].[dbo].[DTA_reports_table] as T ON C.TableID = T.TableID
			JOIN
			[msdb].[dbo].[DTA_reports_database] as D ON T.DatabaseID = D.DatabaseID
			and Q.SessionID = QC.SessionID and 
			Q.SessionID = @SessionID		
			GROUP BY C.ColumnID,T.TableID,D.DatabaseID ) as R

			where R.DatabaseID = D1.DatabaseID and
			R.TableID = T1.TableID and
			R.ColumnID = C1.ColumnID and
			D1.SessionID = @SessionID and
			R.Count > 0

	order by [Database!2!DatabaseID!hide],[Schema!3!Name!ELEMENT],[Table!4!TableID!hide],[Column!5!NumberOfReferences!ELEMENT] , [Column!5!ColumnID!hide] 
	FOR XML EXPLICIT
end
