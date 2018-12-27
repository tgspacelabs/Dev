CREATE TABLE [dbo].[Deadlock] (
    [Creation_Date] DATETIME NULL,
    [Extend_Event]  XML      NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Deadlock testing', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Deadlock';

