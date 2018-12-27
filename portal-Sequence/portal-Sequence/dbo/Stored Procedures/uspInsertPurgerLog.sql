
CREATE PROCEDURE [dbo].[uspInsertPurgerLog]
    (
     @Procedure NVARCHAR(128),
     @Table NVARCHAR(128),
     @PurgeDate DATETIME2(7),
     @Parameters NVARCHAR(128),
     @ChunkSize INT,
     @Rows BIGINT,
     @ErrorNumber INT,
     @ErrorMessage NVARCHAR(MAX),
     @StartTime DATETIME2(7) = '01-01-1900' -- Default to extreme early date until all procedures are updated.
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[PurgerLog]
            ([Procedure],
             [Table],
             [PurgeDate],
             [Parameters],
             [ChunkSize],
             [Rows],
             [ErrorNumber],
             [ErrorMessage],
             [StartTime])
    VALUES
            (@Procedure,
             @Table,
             @PurgeDate,
             @Parameters,
             @ChunkSize,
             @Rows,
             @ErrorNumber,
             @ErrorMessage,
             @StartTime);
END;