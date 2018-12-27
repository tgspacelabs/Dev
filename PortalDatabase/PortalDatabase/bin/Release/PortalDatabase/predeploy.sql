----------------------------------------------------------------------------------------
-- © Copyright 2015 Spacelabs Healthcare, Inc.
--
-- This material contains proprietary, trade secret, and confidential information
-- which is the property of Spacelabs Healthcare. This material and the information
-- it contains are not to be copied, distributed, or disclosed to others without the
-- prior written approval of Spacelabs Healthcare.
--
----------------------------------------------------------------------------------------

/*
 Pre-Deployment Script Template                                   
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.     
 Use SQLCMD syntax to include a file in the pre-deployment script.               
 Example:      :r .\myfile.sql                                        
 Use SQLCMD syntax to reference a variable in the pre-deployment script.          
 Example:      :setvar TableName MyTable                                   
               SELECT * FROM [$(TableName)]                         
--------------------------------------------------------------------------------------
*/

PRINT N'Begin - Pre-Deployment script...';
GO

USE [$(DatabaseName)];
GO

----------------------------------------------------------------------------------------
-- © Copyright 2015 Spacelabs Healthcare, Inc.
--
-- This material contains proprietary, trade secret, and confidential information
-- which is the property of Spacelabs Healthcare. This material and the information
-- it contains are not to be copied, distributed, or disclosed to others without the
-- prior written approval of Spacelabs Healthcare.
--
----------------------------------------------------------------------------------------

/* Please do not change the database path or name variables. It will be properly coded for build 
and deployment.  This example is using sqlcmd variable substitution. */

PRINT N'Set SQL Server options...';

-- Set SQL Server options

EXEC [sys].[sp_configure]
    N'show advanced options',
    1;
GO

RECONFIGURE;
GO

EXEC [sys].[sp_configure]
    N'backup compression default',
    1;
GO

EXEC [sys].[sp_configure]
    N'cost threshold for parallelism',
    100;
GO

DECLARE @MaxDegreeOfParallelism SMALLINT= 0;

SELECT TOP (1)
    @MaxDegreeOfParallelism = CASE WHEN [cpu_count] <= 16 THEN [cpu_count] / 2
                                   ELSE 8
                              END
FROM
    [sys].[dm_os_sys_info];


EXEC [sys].[sp_configure]
    @configname = N'max degree of parallelism',
    @configvalue = @MaxDegreeOfParallelism;
GO

EXEC [sys].[sp_configure]
    N'optimize for ad hoc workloads',
    1;
GO

EXEC [sys].[sp_configure]
    N'priority boost',
    0;
GO

RECONFIGURE;
GO


-- Turn on Deadlock Trace Flags for all sessions

DBCC TRACEON(1204, -1); 
GO

DBCC TRACEON(1222, -1);
GO

RECONFIGURE;
GO

----------------------------------------------------------------------------------------
-- © Copyright 2016 Spacelabs Healthcare, Inc.
--
-- This material contains proprietary, trade secret, and confidential information
-- which is the property of Spacelabs Healthcare. This material and the information
-- it contains are not to be copied, distributed, or disclosed to others without the
-- prior written approval of Spacelabs Healthcare.
--
----------------------------------------------------------------------------------------

/* Please do not change the database path or name variables. It will be properly coded for build 
and deployment.  This example is using sqlcmd variable substitution. */

PRINT N'Set database options...';
GO

-- Set database options

-- SQL Server 2012 Compatibility
/*
ALTER DATABASE [$(DatabaseName)] 
SET COMPATIBILITY_LEVEL = 110;
GO
*/
DECLARE @CompatiblityLevel TINYINT = 0;

SELECT
    @CompatiblityLevel = [s].[cmptlevel]
FROM
    [sys].[sysdatabases] AS [s]
WHERE
    [s].[name] = N'$(DatabaseName)';

PRINT '@CompatiblityLevel = ' + CAST(@CompatiblityLevel AS VARCHAR(30));


-- Log backups not required
ALTER DATABASE [$(DatabaseName)] 
SET RECOVERY SIMPLE;
GO

-- Optimistic concurrency
ALTER DATABASE [$(DatabaseName)] 
SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT;
GO

-- Optimistic concurrency
ALTER DATABASE [$(DatabaseName)] 
SET ALLOW_SNAPSHOT_ISOLATION ON;
GO
:setvar DataLogicalName "@DataLogicalName"
:setvar LogLogicalName "@LogLogicalName"

-- Resizing the database data and log files
DECLARE @DataFileCount SMALLINT = 0;
DECLARE @DataFileSize BIGINT = 0;
DECLARE @LogFileSize BIGINT = 0;
DECLARE @DataLogicalName sysname;
DECLARE @LogLogicalName sysname;
DECLARE @SqlStmt NVARCHAR(4000);

SELECT
    @DataFileCount = COUNT(*),
    @DataFileSize = SUM((CAST([df].[size] AS BIGINT) * 8192) / 1024 / 1024 / 1024)
FROM
    [sys].[database_files] AS [df]
WHERE
    [df].[type] = 0;

SELECT
    @LogFileSize = SUM((CAST([df].[size] AS BIGINT) * 8192) / 1024 / 1024 / 1024)
FROM
    [sys].[database_files] AS [df]
WHERE
    [df].[type] = 1;

PRINT 'Current database size before check and possible update.';
PRINT '  @DataFileCount = ' + CAST(@DataFileCount AS VARCHAR(30));
PRINT '  @DataFileSize = ' + CAST(@DataFileSize AS VARCHAR(30));
PRINT '  @LogFileSize = ' + CAST(@LogFileSize AS VARCHAR(30));

IF (@DataFileCount = 1
    AND @DataFileSize < 12)
BEGIN
    SELECT
        @DataLogicalName = [df].[name]
    FROM
        [sys].[database_files] AS [df]
    WHERE
        [df].[file_id] = 1
        AND [df].[type] = 0;

    PRINT '  @DataLogicalName: ' + @DataLogicalName;

    -- ALTER DATABASE [$(DatabaseName)] MODIFY FILE ( NAME = [$(DataLogicalName)], SIZE = 12GB, MAXSIZE = UNLIMITED, FILEGROWTH = 6GB );
    SET @SqlStmt = N'ALTER DATABASE [$(DatabaseName)] MODIFY FILE ( NAME = [' + @DataLogicalName + N'], SIZE = 12GB, MAXSIZE = UNLIMITED, FILEGROWTH = 6GB );';
    PRINT @SqlStmt;
    EXEC [sys].[sp_executesql] @SqlStmt;
END;

IF (@LogFileSize < 4)
BEGIN
    SELECT
        @LogLogicalName = [df].[name]
    FROM
        [sys].[database_files] AS [df]
    WHERE
        [df].[type] = 1;

    PRINT '  @LogLogicalName: ' + @LogLogicalName;

    -- ALTER DATABASE [$(DatabaseName)] MODIFY FILE ( NAME = [$(LogLogicalName)], SIZE = 4GB, MAXSIZE = UNLIMITED, FILEGROWTH = 4GB );
    SET @SqlStmt = N'ALTER DATABASE [$(DatabaseName)] MODIFY FILE ( NAME = [' + @LogLogicalName + N'], SIZE = 6GB, MAXSIZE = UNLIMITED, FILEGROWTH = 4GB );';
    PRINT @SqlStmt;
    EXEC [sys].[sp_executesql] @SqlStmt;
END;
GO



-- Process the Portal database version = 5.00 or 5.01 upgrade of the [LiveData] and [WaveformLiveData] tables

-- Copy the [LiveData] from the view in preparation to remove the view and replace it with a table.

-- If Portal version = 5.00 or 5.01 then create the temporary ##tmp_LiveData table, copy the data from the LiveData view to the ##tmp_LiveData table.

-- Does [LiveData] view exist?
IF (EXISTS ( SELECT
                1
             FROM
                [sys].[views] AS [v]
             WHERE
                [v].[name] = N'LiveData' ))
BEGIN
    PRINT '';
    PRINT '[LiveData] view exists.';
    PRINT 'Copying [LiveData] view data to temporary table [##tmp_LiveData].';

    IF (OBJECT_ID('[tempdb]..[##tmp_LiveData]') IS NOT NULL)
        DROP TABLE [##tmp_LiveData];

    CREATE TABLE [dbo].[##tmp_LiveData]
        (
         [Id] [UNIQUEIDENTIFIER] NOT NULL,
         [TopicInstanceId] [UNIQUEIDENTIFIER] NOT NULL,
         [FeedTypeId] [UNIQUEIDENTIFIER] NOT NULL,
         [Name] [VARCHAR](25) NOT NULL,
         [Value] [VARCHAR](25) NULL,
         [TimestampUTC] [DATETIME] NOT NULL
        )
    ON  [PRIMARY];

    --TRUNCATE TABLE [dbo].[##tmp_LiveData];

    INSERT  INTO [dbo].[##tmp_LiveData]
            ([Id],
             [TopicInstanceId],
             [FeedTypeId],
             [Name],
             [Value],
             [TimestampUTC])
    SELECT
        [ld].[Id],
        [ld].[TopicInstanceId],
        [ld].[FeedTypeId],
        [ld].[Name],
        [ld].[Value],
        [ld].[TimestampUTC]
    FROM
        [dbo].[LiveData] AS [ld];

    PRINT CAST(@@ROWCOUNT AS VARCHAR(10)) + ' rows copied from [LiveData] view to [##tmp_LiveData].';
    PRINT '';
END;


-- Copy the [WaveformLiveData] from the view in preparation to remove the view and replace it with a table.

-- If Portal version = 5.00 or 5.01 then create the temporary tmp_WaveformLiveData table, copy the data from the WaveformLiveData view into the tmp_WaveformLiveData table.

-- Does [WaveformLiveData] view exist?
IF (EXISTS ( SELECT
                1
             FROM
                [sys].[views] AS [v]
             WHERE
                [v].[name] = N'WaveformLiveData' ))
BEGIN
    PRINT '';
    PRINT '[WaveformLiveData] view exists.';
    PRINT 'Copying [WaveformLiveData] view data to temporary table [##tmp_WaveformLiveData].';

    IF (OBJECT_ID('[tempdb]..[##tmp_WaveformLiveData]') IS NOT NULL)
        DROP TABLE [##tmp_WaveformLiveData];

    CREATE TABLE [dbo].[##tmp_WaveformLiveData]
        (
         [Id] [UNIQUEIDENTIFIER] NOT NULL,
         [SampleCount] [INT] NOT NULL,
         [TypeName] [VARCHAR](50) NULL,
         [TypeId] [UNIQUEIDENTIFIER] NULL,
         [Samples] [VARBINARY](MAX) NOT NULL,
         [TopicInstanceId] [UNIQUEIDENTIFIER] NOT NULL,
         [StartTimeUTC] [DATETIME] NOT NULL,
         [EndTimeUTC] [DATETIME] NOT NULL
        )
    ON  [PRIMARY] TEXTIMAGE_ON [PRIMARY];

    --TRUNCATE TABLE [dbo].[##tmp_LiveData];

    INSERT  INTO [dbo].[##tmp_WaveformLiveData]
            ([Id],
             [SampleCount],
             [TypeName],
             [TypeId],
             [Samples],
             [TopicInstanceId],
             [StartTimeUTC],
             [EndTimeUTC])
    SELECT
        [wld].[Id],
        [wld].[SampleCount],
        [wld].[TypeName],
        [wld].[TypeId],
        [wld].[Samples],
        [wld].[TopicInstanceId],
        [wld].[StartTimeUTC],
        [wld].[EndTimeUTC]
    FROM
        [dbo].[WaveformLiveData] AS [wld];

    PRINT CAST(@@ROWCOUNT AS VARCHAR(10)) + ' rows copied from [WaveformLiveData] view to [##tmp_WaveformLiveData].';
END;



PRINT N'End - Pre-Deployment script...';
GO
