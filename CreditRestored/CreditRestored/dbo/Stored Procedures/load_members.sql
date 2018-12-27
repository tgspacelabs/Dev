
/****** Object:  Stored Procedure dbo.load_members    Script Date: 10/13/99 6:38:03 PM ******/



CREATE PROCEDURE load_members 
   @target_member_count int 
AS
BEGIN
   DECLARE @member_region_no numeric_id
   DECLARE @member_corp_no numeric_id
   DECLARE @member_lastname shortstring
   DECLARE @member_firstname shortstring

   DECLARE @no_of_regions int      SELECT @no_of_regions = COUNT(*) FROM region
   DECLARE @no_of_corps int        SELECT @no_of_corps = COUNT(*) FROM corporation
   DECLARE @no_of_corps_t5 int     SELECT @no_of_corps_t5 = @no_of_corps * 2

   DECLARE tnames_cursor CURSOR FOR SELECT lastname FROM lastname_table

   WHILE @target_member_count > 0
   BEGIN
      BEGIN TRANSACTION

      OPEN tnames_cursor
      WHILE (@@FETCH_STATUS = @@FETCH_STATUS)
      BEGIN
         FETCH NEXT FROM tnames_cursor INTO @member_lastname
         IF (@@FETCH_STATUS <> 0)
            BREAK
         EXEC @member_region_no = skewed_rand @no_of_regions, 1
         EXEC @member_corp_no = skewed_rand @no_of_corps_t5, 2
         IF (@member_corp_no > @no_of_corps) SELECT @member_corp_no = NULL
         EXEC generate_firstname @member_firstname OUTPUT
         EXEC addmember
             @region_no        = @member_region_no
           , @corp_no          = @member_corp_no
           , @lastname         = @member_lastname
           , @firstname        = @member_firstname
           , @middleinitial    = ' '
           , @street           = '  '
           , @city             = '  '
           , @state_prov       = '  '
           , @country          = '  '
           , @mail_code        = '  '
           , @phone_no         = '  '
         SELECT @target_member_count = @target_member_count - 1
      END
      CLOSE tnames_cursor

      COMMIT TRANSACTION
      DUMP TRANSACTION credit WITH TRUNCATE_ONLY
   END
   DEALLOCATE tnames_cursor
END
