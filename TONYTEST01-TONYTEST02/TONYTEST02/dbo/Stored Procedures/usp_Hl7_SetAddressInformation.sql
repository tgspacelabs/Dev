
/*[usp_Hl7_SetAddressInformation] used to update the address*/

CREATE PROCEDURE [dbo].[usp_Hl7_SetAddressInformation]
(
	@AddressId UNIQUEIDENTIFIER,
	@AddrLocCd nchar(2),
	@AddrTypCd nchar(2),
	@SeqNo int,
	@ActiveSw tinyint =null,
	@OrgPatientId UNIQUEIDENTIFIER=null,
	@Line1Dsc NVARCHAR(160) =null,
	@Line2Dsc NVARCHAR(160) =null,
	@Line3Dsc NVARCHAR(160) =null,
	@CityNm NVARCHAR(60) =null,
	@CountryCid int=null,
	@StateCode NVARCHAR(6) =null,
	@ZipCode NVARCHAR(30) =null,
	@StartDt datetime=null
)
AS
BEGIN
if @StartDt = ''
		set @StartDt = GETDATE() 
UPDATE int_address 
	SET 
	active_sw=ISNULL(@ActiveSw,active_sw),
	orig_patient_id=ISNULL(@OrgPatientId,orig_patient_id),
	line1_dsc=ISNULL(@Line1Dsc,line1_dsc),
	line2_dsc=ISNULL(@Line2Dsc,line2_dsc),
	line3_dsc=ISNULL(@Line3Dsc,line3_dsc),
	city_nm=ISNULL(@CityNm,city_nm),
	county_cid=ISNULL(@CountryCid,county_cid),
	state_code=ISNULL(@StateCode,state_code),
	zip_code=ISNULL(@ZipCode,zip_code),
	start_dt=ISNULL(@StartDt,start_dt)
	WHERE address_id=@AddressId 
	AND addr_loc_cd=@AddrLocCd 
	AND addr_type_cd=@AddrTypCd 
	AND seq_no=@SeqNo
END

