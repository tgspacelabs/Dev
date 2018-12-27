EXECUTE sp_addextendedproperty @name = N'version', @value = '3.2.2 (removed incomprehensible CTEs)';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description-TEST', @value = N'This is a test parameter description', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'CreateRole', @level2type = N'PARAMETER', @level2name = N'@role_Name';

