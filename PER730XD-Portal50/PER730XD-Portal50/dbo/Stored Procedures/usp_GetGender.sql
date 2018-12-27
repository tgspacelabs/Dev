CREATE PROCEDURE [dbo].[usp_GetGender]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT imc.[short_dsc] 
    FROM [dbo].[int_misc_code] AS imc
    WHERE imc.[category_cd] = 'SEX' 
        AND imc.[verification_sw] = 1;
END
