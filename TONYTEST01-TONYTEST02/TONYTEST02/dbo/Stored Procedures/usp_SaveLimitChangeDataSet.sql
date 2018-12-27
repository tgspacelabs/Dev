
CREATE PROCEDURE [dbo].[usp_SaveLimitChangeDataSet]
	(@limitChangeData [dbo].[LimitChangeDataType] READONLY)
AS
BEGIN
	
	SET NOCOUNT ON

	INSERT INTO [dbo].[LimitChangeData]
	SELECT * FROM @limitChangeData

END

