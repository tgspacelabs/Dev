

/*[usp_InsertPersonDemographics] used to insert the person name*/
CREATE PROCEDURE [dbo].[usp_InsertPersonDemographics]
(         
	@PersonId             UNIQUEIDENTIFIER,
	@RecognizeNmCd          NVARCHAR(10) = null,
	@SeqNo                  int = NULL, 
	@ActiveSw               tinyint,
	@OrigPatientId          UNIQUEIDENTIFIER = NULL,
	@Prefix                 NVARCHAR(8) = NULL,
	@FirstNm                NVARCHAR(100) = NULL, 
	@MiddleNm               NVARCHAR(100) = NULL, 
	@LastNm                 NVARCHAR(100) = NULL, 
	@Suffix                 NVARCHAR(10) = NULL, 
	@Degree                 NVARCHAR(40) = NULL, 
	@mpiLnamecons         NVARCHAR(40) = NULL, 
	@mpiFnameCons         NVARCHAR(40) = NULL, 
	@mpiMnameCons         NVARCHAR(40) = NULL,
	@startDt			 datetime=null
)
AS
BEGIN
IF @startDt IS NULL SET @startDt=GETDATE(); 

INSERT INTO int_person_name 
(
	person_nm_id, 
	recognize_nm_cd, 
	seq_no, 
	active_sw, 
	orig_patient_id, 
	prefix, 
	first_nm, 
	middle_nm, 
	last_nm, 
	suffix, 
	degree, 
	mpi_lname_cons, 
	mpi_fname_cons, 
	mpi_mname_cons, 
	start_dt
)
VALUES 
(
	@PersonId, 
	@RecognizeNmCd, 
	@SeqNo, 
	@ActiveSw, 
	@OrigPatientId, 
	@Prefix, 
	@FirstNm, 
	@MiddleNm, 
	@LastNm, 
	@Suffix,
	@Degree,
	@mpiLnameCons, 
	@mpiFnameCons, 
	@mpiMnameCons,
	@startDt
)
End

