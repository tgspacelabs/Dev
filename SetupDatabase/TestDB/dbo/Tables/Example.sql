CREATE TABLE [dbo].[Example] (
    [SomeID]    INT  NOT NULL,
    [StartDate] DATE NOT NULL,
    [EndDate]   DATE NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [CX_Example_SomeID_StartDate]
    ON [dbo].[Example]([SomeID] ASC, [StartDate] ASC) WITH (FILLFACTOR = 100);

