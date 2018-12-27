

CREATE PROCEDURE [dbo].[p_cb_Load_hcp_List]
    (
     @LastName VARCHAR(50),
     @FirstName VARCHAR(50),
     @TypeCodeId INT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @Query VARCHAR(8000),
        @WhereClause SMALLINT;

    SET @WhereClause = 0;
    SET @Query = 'SELECT
                     h.*,
                     current_dt = GETDATE(),
                     int_organization.organization_id,
                     m.hcp_xid,
                     int_misc_code.code,
                     organization_nm
                   FROM
                     int_misc_code
                       RIGHT OUTER JOIN int_hcp h ON (int_misc_code.code_id = h.hcp_type_cid)
                       INNER JOIN int_hcp_map m ON (h.hcp_id = m.hcp_id)
                       LEFT OUTER JOIN int_organization ON (m.organization_id = int_organization.organization_id)';

    IF @LastName <> ''
    BEGIN
        SET @WhereClause = 1;
        SET @Query = @Query + ' WHERE h.last_nm like ''' + @LastName + '%''';
    END;

    IF @FirstName <> ''
        IF @WhereClause = 0
        BEGIN
            SET @WhereClause = 1;
            SET @Query = @Query + ' WHERE h.first_nm like ''' + @FirstName + '%''';
        END;
        ELSE
            SET @Query = @Query + ' AND h.first_nm like ''' + @FirstName + '%''';

    IF @TypeCodeId <> 0
        IF @WhereClause = 0
            SET @Query = @Query + ' WHERE h.hcp_type_cid  = ' + CAST(@TypeCodeId AS VARCHAR);
        ELSE
            SET @Query = @Query + ' AND h.hcp_type_cid  = ' + CAST(@TypeCodeId AS VARCHAR);

    EXEC(@Query);

END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_cb_Load_hcp_List';

