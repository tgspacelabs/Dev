/*
Do not change the database path or name variables.
Any sqlcmd variables will be properly substituted during 
build and deployment.
*/
ALTER DATABASE [$(DatabaseName)]
ADD LOG FILE
(
    NAME = [Database7_Log],
    FILENAME = '$(DefaultLogPath)$(DefaultFilePrefix)_Log.ldf',
    SIZE = 1024 MB,
    FILEGROWTH = 1024 MB,
    MAXSIZE = UNLIMITED
)
