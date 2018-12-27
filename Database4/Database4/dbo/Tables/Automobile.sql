CREATE TABLE [dbo].[Automobile]
(
    [AutomobileID] INT NOT NULL  IDENTITY, 
    [Manufacturer] NVARCHAR(100) NOT NULL, 
    [Model] NVARCHAR(100) NOT NULL, 
    CONSTRAINT [PK_Automobile_AutomobileID] PRIMARY KEY ([AutomobileID])
)
