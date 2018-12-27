
/*usp_HL7_UpdatePersonDemographics is used to update the person demographics*/
CREATE PROCEDURE [dbo].usp_HL7_UpdatePersonDemographics
(         
	@PersonId         UNIQUEIDENTIFIER,
	@FirstNm          NVARCHAR(100), 
	@LastNm           NVARCHAR(100),
	@MiddleNm         NVARCHAR(100),
	@TelNo            NVARCHAR(80),
	@CityNm           NVARCHAR(50), 
	@StateCode        NVARCHAR(60), 
	@ZipCode          NVARCHAR(6), 
	@Suffix           NVARCHAR(10), 
	@Line1Dsc         NVARCHAR(160), 
	@Line2Dsc         NVARCHAR(160), 
	@CountryCid       int
)
AS
BEGIN
UPDATE int_person 
SET
	first_nm = @FirstNm,
    last_nm = @LastNm,
    middle_nm = @MiddleNm,
    tel_no =@TelNo,
    city_nm =@CityNm,
    state_code = @StateCode,
    zip_code = @ZipCode,
    suffix = @Suffix,
    line1_dsc = @Line1Dsc,
    line2_dsc =@Line2Dsc,
    country_cid = @CountryCid 
WHERE ( person_id = @PersonId )
End
