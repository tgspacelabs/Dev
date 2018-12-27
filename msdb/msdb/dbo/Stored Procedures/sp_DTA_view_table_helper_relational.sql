﻿	create procedure sp_DTA_view_table_helper_relational
						@SessionID		int
						as
						begin  select "View Id" =T2.TableID, "Database Name" =D.DatabaseName, "Schema Name" =T2.SchemaName, "View Name" =T2.TableName, "Database Name" =D.DatabaseName, "Schema Name" =T1.SchemaName, "Table Name" =T1.TableName 	from 
					[msdb].[dbo].[DTA_reports_database] D, 
					[msdb].[dbo].[DTA_reports_tableview] TV, 
					[msdb].[dbo].[DTA_reports_table] T1,
					[msdb].[dbo].[DTA_reports_table] T2
					where 
						D.DatabaseID=T1.DatabaseID and 
						D.DatabaseID=T2.DatabaseID and
						T1.TableID=TV.TableID and 
						T2.TableID=TV.ViewID and
						D.SessionID=@SessionID
						order by TV.ViewID  end 