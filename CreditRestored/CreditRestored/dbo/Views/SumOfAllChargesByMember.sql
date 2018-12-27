
CREATE VIEW [dbo].[SumOfAllChargesByMember]
	WITH SCHEMABINDING  -- required if you plan to index this view!
AS
SELECT [c].[member_no] AS [MemberNo], 
	COUNT_BIG(*) AS [NumberOfCharges], -- required when GROUP BY is in an indexed view!
	SUM([c].[charge_amt]) AS [TotalSales]
FROM [dbo].[charge] AS [c]
GROUP BY [c].[member_no];

GO
CREATE UNIQUE CLUSTERED INDEX [SumofAllChargesIndex]
    ON [dbo].[SumOfAllChargesByMember]([MemberNo] ASC);

