

--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [uspInsertCustomer]
    (
     @FirstName NVARCHAR(40),
     @LastName NVARCHAR(20),
     @Company NVARCHAR(80),
     @Address NVARCHAR(70),
     @City NVARCHAR(40),
     @State NVARCHAR(40),
     @Country NVARCHAR(40),
     @PostalCode NVARCHAR(10),
     @Phone NVARCHAR(24),
     @Fax NVARCHAR(24),
     @Email NVARCHAR(60),
     @SupportRepId INT
    )
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[Customer]
            ([FirstName],
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
             [SupportRepId])
    VALUES
            (N'', -- FirstName - nvarchar(40)
             N'', -- LastName - nvarchar(20)
             N'', -- Company - nvarchar(80)
             N'', -- Address - nvarchar(70)
             N'', -- City - nvarchar(40)
             N'', -- State - nvarchar(40)
             N'', -- Country - nvarchar(40)
             N'', -- PostalCode - nvarchar(10)
             N'', -- Phone - nvarchar(24)
             N'', -- Fax - nvarchar(24)
             N'', -- Email - nvarchar(60)
             0  -- SupportRepId - int
             );
END;