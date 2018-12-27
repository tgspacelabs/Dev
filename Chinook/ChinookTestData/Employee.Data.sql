

INSERT INTO [dbo].[Employee]
        ([LastName],
         [FirstName],
         [Title],
         [ReportsTo],
         [BirthDate],
         [HireDate],
         [Address],
         [City],
         [State],
         [Country],
         [PostalCode],
         [Phone],
         [Fax],
         [Email])
VALUES
        (N'Green', -- LastName - nvarchar(20)
         N'Sherry', -- FirstName - nvarchar(20)
         N'CEO', -- Title - nvarchar(30)
         1, -- ReportsTo - int
         '3-4-1956', -- BirthDate - datetime
         '01-01-2014', -- HireDate - datetime
         N'', -- Address - nvarchar(70)
         N'', -- City - nvarchar(40)
         N'', -- State - nvarchar(40)
         N'', -- Country - nvarchar(40)
         N'', -- PostalCode - nvarchar(10)
         N'', -- Phone - nvarchar(24)
         N'', -- Fax - nvarchar(24)
         N''  -- Email - nvarchar(60)
         );
