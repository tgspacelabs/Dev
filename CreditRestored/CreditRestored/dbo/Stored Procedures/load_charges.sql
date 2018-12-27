
/****** Object:  Stored Procedure dbo.load_charges    Script Date: 10/13/99 6:38:03 PM ******/

CREATE PROCEDURE load_charges 
    @target_charge_count int
AS
BEGIN
   DECLARE @charge_category_no int
   DECLARE @charge_provider_no int
   DECLARE @charge_member_no int
   DECLARE @charge_charge_dt datetime
   DECLARE @charge_charge_amt money

   DECLARE @no_of_members int       SELECT @no_of_members = COUNT(*) FROM member
   DECLARE @no_of_providers int     SELECT @no_of_providers = COUNT(*) FROM provider
   DECLARE @no_of_categories int    SELECT @no_of_categories = COUNT(*) FROM category

   DECLARE @tran_size int           SELECT @tran_size = 4000

   BEGIN TRANSACTION
   WHILE @target_charge_count > 0
   BEGIN
      SELECT @target_charge_count = @target_charge_count - 1
      IF (@target_charge_count % @tran_size = 0) 
      BEGIN
         COMMIT TRANSACTION
         DUMP TRANSACTION credit WITH TRUNCATE_ONLY
         BEGIN TRANSACTION
      END

      EXEC @charge_category_no = skewed_rand @no_of_categories, 1
      EXEC @charge_provider_no = skewed_rand @no_of_providers, 3
      EXEC @charge_member_no   = skewed_rand @no_of_members, 2
      SELECT @charge_charge_dt = dateadd(day, -(rand()*120), getdate())
      SELECT @charge_charge_amt = convert(money, round((rand() * 5000 + 1), 0))

      EXEC inputcharge
          @member_no        = @charge_member_no   
        , @provider_no      = @charge_provider_no
        , @category_no      = @charge_category_no
        , @charge_dt        = @charge_charge_dt
        , @charge_amt       = @charge_charge_amt
   END
   COMMIT TRANSACTION
END
