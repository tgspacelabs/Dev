/*
Do not change the database path or name variables.
Any sqlcmd variables will be properly substituted during 
build and deployment.
*/
ALTER DATABASE [$(DatabaseName)]
    ADD FILE 
    (
        NAME = [Database7_LiveData],
        FILENAME = '$(DefaultDataPath)$(DefaultFilePrefix)_LiveData.ndf',
        SIZE = 1024 MB,
        FILEGROWTH = 1024 MB,
        MAXSIZE = UNLIMITED
    ) 
TO FILEGROUP [LiveData]
