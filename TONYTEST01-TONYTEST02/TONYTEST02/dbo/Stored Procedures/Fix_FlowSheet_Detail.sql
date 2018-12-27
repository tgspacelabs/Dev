
/* fix flowsheet_detail rows
   the sub test test_code id from cmplus
   points to its parent's test code
   had to generate new ones
*/
CREATE PROCEDURE [dbo].[Fix_FlowSheet_Detail]
AS
  DECLARE
    @detail_id UNIQUEIDENTIFIER,
    @org_id    UNIQUEIDENTIFIER,
    @sys_id    UNIQUEIDENTIFIER,
    @name      VARCHAR(60),
    @test_cid  INT,
    @code_id   INT,
    @cnt       INT,
    @code      VARCHAR(20)

  SELECT @sys_id = sys_id,
         @org_id = organization_id
  FROM   int_send_sys
  WHERE  code = 'GTWY'

  DECLARE TCURSOR CURSOR FOR
    SELECT flowsheet_detail_id,
           name,
           test_cid
    FROM   int_flowsheet_detail
    WHERE  detail_type = 'fdtSub'

  SET NOCOUNT ON

  OPEN TCURSOR

  FETCH NEXT FROM TCURSOR INTO @detail_id, @name, @test_cid

  WHILE ( @@FETCH_STATUS = 0 )
    BEGIN
      SELECT @detail_id,
             @name,
             @test_cid

      /*
        select @code_id = code_id
        from int_misc_code
        where code = @name
        and category_cd = 'ATST'
        and method_cd = 'GDS'
      
        select @cnt = count(*)
        from int_misc_code
        where code = @name
        and category_cd = 'ATST'
        and method_cd = 'GDS'
      
      
        if (@cnt = 0)
        begin 
          select @code_id = max(code_id) + 1 from int_misc_code
          insert into int_misc_code (code_id, organization_id, sys_id, category_cd, method_cd, code, verification_sw, int_keystone_cd, short_dsc)
          values (@code_id, @org_id, @sys_id, 'ATST', 'GDS', @name, null, @name, @name)
        end  
      */

      SELECT @code_id = MAX(code_id) + 1
      FROM   int_misc_code

      SELECT @code = CONVERT( VARCHAR(20), @code_id )

      INSERT INTO int_misc_code
                  (code_id,
                   organization_id,
                   sys_id,
                   category_cd,
                   method_cd,
                   code,
                   verification_sw,
                   int_keystone_cd,
                   short_dsc)
      VALUES      (@code_id,
                   @org_id,
                   @sys_id,
                   'ATST',
                   'GDS',
                   @code,
                   NULL,
                   @name,
                   @name)

      UPDATE int_flowsheet_detail
      SET    test_cid = @code_id
      WHERE  flowsheet_detail_id = @detail_id

      FETCH NEXT FROM TCURSOR INTO @detail_id, @name, @test_cid
    END

  SET NOCOUNT OFF

  CLOSE TCURSOR

  DEALLOCATE TCURSOR


