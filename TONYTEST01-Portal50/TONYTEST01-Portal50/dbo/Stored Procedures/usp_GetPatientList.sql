CREATE PROCEDURE [dbo].[usp_GetPatientList]
(
	@filters NVARCHAR(MAX),
	@showADTEncounters bit
)
AS
BEGIN
DECLARE @QUERY     NVARCHAR(MAX)

SET @QUERY ='SELECT
	[FIRST_NAME] AS ''First Name'',
	[LAST_NAME] AS ''Last Name'',
	[MRN_ID] AS ''Patient ID'',
	[ACCOUNT_ID] AS ''Patient ID2'',
	[DOB] AS DOB,
	(ISNULL(org1.organization_cd, ''-'') + '' '' + ISNULL(org2.organization_cd, ''-'') + '' '' + ISNULL([ROOM], ''-'') + '' '' + ISNULL([BED], ''-'')) AS ''Location'',
	[MONITOR_NAME] AS Device,
	[LAST_RESULT] AS ''Last Result'',
	[ADMIT] AS Admitted,
	[DISCHARGED] AS Discharged,
	[SUBNET] AS Subnet,
	[PATIENT_ID] AS GUID,
	[FACILITY_PARENT_ID] AS [parent_organization_id]

	FROM [dbo].[v_CombinedEncounters]
	INNER JOIN [int_organization] AS [org1] ON [org1].[organization_id]=[FACILITY_ID]
	INNER JOIN [int_organization] AS [org2] ON [org2].[organization_id]=[UNIT_ID]

	WHERE [MERGE_CD]=''C''
'

	IF (@showADTEncounters<>1)
	SET @QUERY =@QUERY+ ' AND ([PATIENT_MONITOR_ID] IS NOT NULL) AND ([MONITOR_CREATED] = 1)'
																
	IF(LEN(@filters) >0)
	BEGIN
		SET @QUERY = @QUERY + 'AND '
		SET @QUERY  = @QUERY + @filters
	END

    EXEC(@QUERY);
END

