

CREATE PROCEDURE [uspGetCustomers]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [CustomerId],
        [FirstName],
        [LastName],
        [Company],
        [Address],
        [City],
        [State],
        [Country],
        [PostalCode],
        [Phone],
        [Fax],
        [Email],
        [SupportRepId]
    FROM
        [dbo].[Customer];
END;