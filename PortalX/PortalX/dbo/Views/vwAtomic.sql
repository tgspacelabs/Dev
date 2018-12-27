
CREATE VIEW [dbo].[vwAtomic]
WITH SCHEMABINDING, VIEW_METADATA
AS
SELECT
    --[a].[AtomicID],
    [a].[Type] AS [TypeX],
    [a].[Data] AS [DataX]
FROM [dbo].[Atomic] AS [a]
WHERE [a].[Type] = 'TEST'
WITH CHECK OPTION;
