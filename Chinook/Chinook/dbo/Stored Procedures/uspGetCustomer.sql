

CREATE PROCEDURE [uspGetCustomer] (@CustomerID INT)
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
        [dbo].[Customer]
    WHERE
        [CustomerId] = @CustomerID;
END;