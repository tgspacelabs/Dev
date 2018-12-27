CREATE TABLE [dbo].[Employee] (
    [EmployeeID] INT           IDENTITY (1, 1) NOT NULL,
    [FirstName]  NVARCHAR (50) NOT NULL,
    [LastName]   NVARCHAR (50) NOT NULL,
    [Birthdate]  DATETIME2 (7) NULL,
    PRIMARY KEY CLUSTERED ([EmployeeID] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_Employee_LastName]
    ON [dbo].[Employee]([LastName] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_Employee_LastName_FirstName]
    ON [dbo].[Employee]([LastName] ASC, [FirstName] ASC) WITH (FILLFACTOR = 100);

