CREATE PROCEDURE [dbo].[usp_GetUDICode]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--SELECT TOP(1)
	--	[idv].[UDICode]
	--FROM
	--	[dbo].[int_db_ver] AS [idv]
	--ORDER BY
	--	[idv].[install_dt] DESC
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Retrieve the UDI code from the ICS version table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetUDICode';

