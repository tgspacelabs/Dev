CREATE PROCEDURE ShowQueryText
AS
BEGIN
    SELECT TOP 10
        object_id,
        name
    FROM
        [sys].[objects];

    --WAITFOR DELAY '00:00:00';

    SELECT TOP 10
        object_id,
        name
    FROM
        [sys].[objects];

    SELECT TOP 10
        object_id,
        name
    FROM
        [sys].[procedures];
END
