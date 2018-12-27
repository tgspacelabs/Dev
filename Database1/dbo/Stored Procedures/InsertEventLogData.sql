﻿

CREATE PROCEDURE [dbo].[InsertEventLogData]
    (
     @LogId VARCHAR(64),
     @PatientID DPATIENT_ID,
     @Application VARCHAR(256),
     @DeviceName VARCHAR(256),
     @Message VARCHAR(MAX),
     @LocalizedMessage VARCHAR(MAX),
     @MessageId INT,
     @LogType VARCHAR(64)
    )
AS
BEGIN
    SET NOCOUNT ON;
	

    INSERT  INTO [dbo].[LogData]
            ([LogId],
             [DateTime],
             [PatientID],
             [Application],
             [DeviceName],
             [Message],
             [LocalizedMessage],
             [MessageId],
             [LogType]
            )
    VALUES
            (@LogId,
             GETDATE(),
             @PatientID,
             @Application,
             @DeviceName,
             @Message,
             @LocalizedMessage,
             @MessageId,
             @LogType
            );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'InsertEventLogData';

