
CREATE PROCEDURE [dbo].[p_cb_Load_User_List]
  (
  @LastName  VARCHAR(50),
  @FirstName VARCHAR(50),
  @LoginId   VARCHAR(64)
  )
AS
  BEGIN
    DECLARE
      @Query       VARCHAR(8000),
      @WhereClause SMALLINT

    SET @WhereClause = 0
    SET @Query = 'SELECT
                    u.user_id,
                    u.login_name,
                    u.password,
                    u.last_nm,
                    u.first_nm,
                    u.middle_nm,
                    u.activate_dt,
                    u.expire_dt,
                    u.force_pw_chg,
                    u.password_chg_dt,
                    current_dt = getdate(),
                    user_category_cd = c.role_name,
                    c.user_role_id,
                    u.account_disabled,
                    u.hcp_id,
                    u.admin_user
                  FROM
                    int_user_role c
                      RIGHT OUTER JOIN int_user u ON (c.user_role_id = u.user_role_id)'

    IF ( @LastName <> '' )
      BEGIN
        SET @Query = @Query + ' Where u.last_nm like ''' + @LastName + '%'''
        SET @WhereClause = 1
      END

    IF ( @FirstName <> '' )
      IF @WhereClause = 0
        BEGIN
          SET @Query = @Query + ' Where u.first_nm like ''' + @FirstName + '%'''
          SET @WhereClause = 1
        END
      ELSE
        SET @Query = @Query + ' and u.first_nm like ''' + @FirstName + '%'''

    IF ( @LoginId <> '' )
      IF @WhereClause = 0
        SET @Query = @Query + ' Where u.login_name like ''' + @LoginId + '%'''
      ELSE
        SET @Query = @Query + ' and u.login_name like ''' + @LoginId + '%'''

    SET @Query = @Query + ' ORDER BY login_name'

    EXEC(@Query)
  END


