
CREATE PROCEDURE [dbo].[GetSumOfAllChargesByMemberNo]
    (@member_no int)
AS
SELECT [sc].* 
FROM [dbo].[SumOfAllChargesByMember] AS [sc]
WHERE [sc].[MemberNo] = @member_no;
