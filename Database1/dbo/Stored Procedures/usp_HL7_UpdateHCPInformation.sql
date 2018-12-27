
CREATE PROCEDURE [dbo].[usp_HL7_UpdateHCPInformation]
    (
     @hcpId UNIQUEIDENTIFIER,
     @LastNm NVARCHAR(100) = NULL,
     @FirstNm NVARCHAR(100) = NULL,
     @MiddleNm NVARCHAR(100) = NULL,
     @Degree NVARCHAR(40) = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE
        [dbo].[int_hcp]
    SET
        [last_nm] = @LastNm,
        [first_nm] = @FirstNm,
        [middle_nm] = @MiddleNm,
        [degree] = @Degree
    WHERE
        [hcp_id] = @hcpId;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_UpdateHCPInformation';

