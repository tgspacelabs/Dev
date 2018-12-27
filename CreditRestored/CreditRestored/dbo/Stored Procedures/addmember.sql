
/****** Object:  Stored Procedure dbo.addmember    Script Date: 10/13/99 6:38:02 PM ******/



CREATE PROCEDURE addmember
    @region_no        numeric_id
  , @corp_no          numeric_id
  , @lastname         shortstring
  , @firstname        shortstring
  , @middleinitial    shortstring
  , @street           shortstring
  , @city             shortstring
  , @state_prov       statecode
  , @country          countrycode
  , @mail_code        mailcode
  , @phone_no         phonenumber 
AS 
    INSERT [Member]
        (  region_no,  corp_no,  lastname,  firstname,  middleinitial,  street,  city,  state_prov,  country,  mail_code,  phone_no)
      VALUES    
        ( @region_no, @corp_no, @lastname, @firstname, @middleinitial, @street, @city, @state_prov, @country, @mail_code, @phone_no)

    IF @@error != 0
       RETURN (-99)
    ELSE
       RETURN 0
