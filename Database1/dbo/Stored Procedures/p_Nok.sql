

CREATE PROCEDURE [dbo].[p_Nok]
    (
     @patient_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @max_seq_no INT;

    SELECT
        @max_seq_no = MAX([seq_no])
    FROM
        [dbo].[int_nok]
    WHERE
        [patient_id] = @patient_id;

    SELECT
        [N].[patient_id],
        [N].[notify_seq_no] [PRIORITY],
        [N].[relationship_cid],
        [A].[line1_dsc] [ADDR1],
        [A].[line2_dsc] [ADDR2],
        [A].[line3_dsc] [ADDR3],
        [A].[city_nm] [CITY],
        [A].[state_code] [STATE],
        [A].[zip_code] [ZIPCODE],
        [A].[country_cid],
        [P].[last_nm] [LASTNAME],
        [P].[first_nm] [FIRSTNAME],
        [P].[middle_nm] [MIDDLENAME],
        [T1].[tel_no] + [T1].[ext_no] [HOME_PHONE],
        [T2].[tel_no] + [T2].[ext_no] [BUSINESS_PHONE]
    FROM
        [dbo].[int_nok] [N]
        RIGHT OUTER JOIN [dbo].[int_address] [A] ON ([N].[nok_person_id] = [A].[address_id])
        RIGHT OUTER JOIN [dbo].[int_telephone] [T1] ON ([N].[nok_person_id] = [T1].[phone_id])
        RIGHT OUTER JOIN [dbo].[int_telephone] [T2] ON ([N].[nok_person_id] = [T2].[phone_id]),
        [dbo].[int_person_name] [P]
    WHERE
        [P].[person_nm_id] = [N].[nok_person_id]
        AND [P].[recognize_nm_cd] = 'P'
        AND [N].[active_flag] = 1
        AND [N].[patient_id] = @patient_id
        AND [T1].[phone_loc_cd] = 'R'
        AND [T1].[phone_type_cd] = 'V'
        AND [T1].[seq_no] = (SELECT
                            MIN([seq_no])
                         FROM
                            [dbo].[int_telephone]
                         WHERE
                            [phone_loc_cd] = 'R'
                            AND [phone_id] = [N].[nok_person_id]
                            AND [phone_type_cd] = 'V'
                        )
        AND [T2].[phone_loc_cd] = 'B'
        AND [T2].[phone_type_cd] = 'V'
        AND [T2].[seq_no] = (SELECT
                            MIN([seq_no])
                         FROM
                            [dbo].[int_telephone]
                         WHERE
                            [phone_loc_cd] = 'B'
                            AND [phone_id] = [N].[nok_person_id]
                            AND [phone_type_cd] = 'V'
                        )
    ORDER BY
        [PRIORITY];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Nok';

