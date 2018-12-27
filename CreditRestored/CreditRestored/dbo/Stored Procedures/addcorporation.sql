
/****** Object:  Stored Procedure dbo.addcorporation    Script Date: 10/13/99 6:38:02 PM ******/


CREATE PROCEDURE addcorporation
    @region_no        numeric_id
  , @corp_name        normstring
  , @street           shortstring
  , @city             shortstring
  , @state_prov       statecode
  , @country          countrycode
  , @mail_code        mailcode
  , @phone_no         phonenumber 
  , @expr_dt          datetime
AS 
    INSERT corporation
        (  region_no,  corp_name,  street,  city,  state_prov,  country,  mail_code,  phone_no,  expr_dt)
      VALUES    
        ( @region_no, @corp_name, @street, @city, @state_prov, @country, @mail_code, @phone_no, @expr_dt)

    IF @@error != 0
       RETURN (-99)
    ELSE
       RETURN 0
