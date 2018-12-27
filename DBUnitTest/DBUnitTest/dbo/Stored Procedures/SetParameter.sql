CREATE PROCEDURE [dbo].[SetParameter]
    @Key NVARCHAR(50),
    @Value NVARCHAR(100)
AS
BEGIN
    INSERT  INTO [dbo].[Parameter]
            ([Key], [Value])
    VALUES
            (@Key, @Value);

    RETURN 0;
END;
