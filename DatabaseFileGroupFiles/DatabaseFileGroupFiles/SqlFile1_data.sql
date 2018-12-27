/*
Do not change the database path or name variables.
Any sqlcmd variables will be properly substituted during 
build and deployment.
*/
ALTER DATABASE [$(DatabaseName)]
    ADD FILE
    (
        NAME = [SqlFile_Data],
        FILENAME = '$(DefaultDataPath)$(DefaultFilePrefix)_Data.ndf',
        SIZE = 1024 MB,
        FILEGROWTH = 1024 MB,
        MAXSIZE = UNLIMITED
    )
    
