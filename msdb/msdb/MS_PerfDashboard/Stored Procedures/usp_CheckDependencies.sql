
create procedure MS_PerfDashboard.usp_CheckDependencies
as
begin
	declare @Version nvarchar(100)
	declare @MajorVer tinyint, @MinorVer tinyint, @BuildNum smallint
	declare @dec1 int, @dec2 int, @dec3 int

	select @Version = convert(nvarchar(100), serverproperty('ProductVersion'))
	select @dec1 = charindex('.', @Version)

	select @MajorVer = convert(tinyint, substring(@Version, 1, @dec1 - 1));
	
	select @MajorVer as major_version, 
		NULL as minor_version, 
		NULL as build_number,
		convert(nvarchar(128), SERVERPROPERTY('MachineName')) + 
			CASE WHEN convert(nvarchar(128), SERVERPROPERTY('InstanceName')) IS NOT NULL THEN N'\' + convert(nvarchar(128), SERVERPROPERTY('InstanceName'))
			ELSE N''
			END as ServerInstance,
		@Version as ProductVersion,
		serverproperty('ProductLevel') as ProductLevel,
		serverproperty('Edition') as Edition

	if not (@MajorVer >= 10)
	begin
		RAISERROR('This server does not meet the requirements (SQL 2008 or later) for running the Performance Dashboard Reports.  This server is running version %s', 18, 1, @Version)
	end
end
