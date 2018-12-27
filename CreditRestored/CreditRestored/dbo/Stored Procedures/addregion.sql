
/****** Object:  Stored Procedure dbo.addregion    Script Date: 10/13/99 6:38:02 PM ******/


CREATE PROCEDURE addregion
    @region_name      shortstring
  , @street           shortstring
  , @city             shortstring
  , @state_prov       statecode
  , @country          countrycode
  , @mail_code        mailcode
  , @phone_no         phonenumber 
AS 
    INSERT region
        (  region_name,  street,  city,  state_prov,  country,  mail_code,  phone_no)
      VALUES    
        ( @region_name, @street, @city, @state_prov, @country, @mail_code, @phone_no)

    IF @@error != 0
       RETURN (-99)
    ELSE
       RETURN 0
