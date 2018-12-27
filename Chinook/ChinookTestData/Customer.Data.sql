

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
        (N'Tony', -- FirstName - nvarchar(40)
         N'Green', -- LastName - nvarchar(20)
         N'Spacelabs Healthcare', -- Company - nvarchar(80)
         N'35301 SE Center St', -- Address - nvarchar(70)
         N'Snoqualmie', -- City - nvarchar(40)
         N'WA', -- State - nvarchar(40)
         N'United States', -- Country - nvarchar(40)
         N'98065', -- PostalCode - nvarchar(10)
         N'425-396-3300', -- Phone - nvarchar(24)
         N'425-396-3301', -- Fax - nvarchar(24)
         N'tony.green@spacelabs.com', -- Email - nvarchar(60)
         1  -- SupportRepId - int
         );
