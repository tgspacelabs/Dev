
/****** Object:  Stored Procedure dbo.addprovider    Script Date: 10/13/99 6:38:02 PM ******/


CREATE PROCEDURE addprovider
    @region_no        numeric_id
  , @provider_name    shortstring
  , @street           shortstring
  , @city             shortstring
  , @state_prov       statecode
  , @country          countrycode
  , @mail_code        mailcode
  , @phone_no         phonenumber 
AS 
    INSERT provider
        (  region_no,  provider_name,  street,  city,  state_prov,  country,  mail_code,  phone_no)
      VALUES    
        ( @region_no, @provider_name, @street, @city, @state_prov, @country, @mail_code, @phone_no)

    IF @@error != 0
       RETURN (-99)
    ELSE
       RETURN 0
