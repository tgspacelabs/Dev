
CREATE PROCEDURE [dbo].[Change_Starter_Set]
  (
  @lang_code VARCHAR (5)
  )
AS
  /*************************************************************************************************
    Procedure Name			:	Change_Starter_Set
            
    Parameters:	Language Column	ex:   fra --French, deu -- German, nld -- Dutch, etc
    Output Parameter:	Null                  
    Purpose: To Change the UI from one Language to other, this procedure is Executed, to update the 
             respective strings in respective columns. If we want to change the language from English 
             to French, then we have to give 'FRA' as the parameter
    Tables Involved: int_misc_code, int_test_group, int_test_group_detail,
                         int_order_group, int_site_link, int_environment and int_starter_set
    Date of  Modification		:	30 June 2006                                                     
    Modification/Add:	For localization of ICS, we need to implement some more strings from int_misc_code 
                      to complete the process. For this we have to included these strings in int_starter_set 
                      table for translation. After translation we have to update the relative strings in  
                      int_misc_code table. This modified procedure updates the relative fields in int_misc_code table.
  
                          Modified SQL Injections are Commented in format 
  **************************************************************************************************/

  SET NOCOUNT ON

  DECLARE @sql VARCHAR(255)

  /* build an empty temp table */
  SELECT set_type_cd,
         guid,
         int_id1,
         int_id2,
         int_id3,
         enu,
         enu AS TO_LANG
  INTO   #TMP_STARTER_SET
  FROM   int_starter_set
  WHERE  set_type_cd = 'FS'

  TRUNCATE TABLE #TMP_STARTER_SET

  /* now fill up temp table, to_lang column contains the value for the language we are going to */
  SET @sql = 'SELECT set_type_cd, guid, int_id1, int_id2, int_id3, enu,'

  SET @sql = @sql + @lang_code + ' AS to_lang'

  SET @sql = @sql + '  FROM [dbo].[int_starter_set]'

  INSERT INTO #TMP_STARTER_SET
  EXEC(@sql)

  /* now update the tables */
  SET NOCOUNT OFF

  --*******    Added on 30 June 2006 for Localization  ********
  UPDATE int_misc_code
  SET    int_keystone_cd = to_lang
  FROM   #TMP_STARTER_SET
  WHERE  set_type_cd = 'GDS-U' AND int_misc_code.code_id = #tmp_starter_set.int_id1 AND int_misc_code.code_id = #tmp_starter_set.int_id2 AND int_misc_code.code_id = #tmp_starter_set.int_id3

  UPDATE int_misc_code
  SET    short_dsc = to_lang
  FROM   #TMP_STARTER_SET
  WHERE  set_type_cd = 'GDS' AND int_misc_code.code_id = #tmp_starter_set.int_id1 AND int_misc_code.code_id = #tmp_starter_set.int_id2 AND int_misc_code.code_id = #tmp_starter_set.int_id3

  UPDATE int_misc_code
  SET    int_keystone_cd = to_lang
  FROM   #TMP_STARTER_SET
  WHERE  set_type_cd = 'HL7-U' AND int_misc_code.code_id = #tmp_starter_set.int_id1 AND int_misc_code.code_id = #tmp_starter_set.int_id2 AND int_misc_code.code_id = #tmp_starter_set.int_id3

  UPDATE int_misc_code
  SET    short_dsc = to_lang
  FROM   #TMP_STARTER_SET
  WHERE  set_type_cd = 'HL7' AND int_misc_code.code_id = #tmp_starter_set.int_id1 AND int_misc_code.code_id = #tmp_starter_set.int_id2 AND int_misc_code.code_id = #tmp_starter_set.int_id3

  UPDATE int_misc_code
  SET    short_dsc = to_lang
  FROM   #TMP_STARTER_SET
  WHERE  set_type_cd = 'S5N' AND int_misc_code.code_id = #tmp_starter_set.int_id1 AND int_misc_code.code_id = #tmp_starter_set.int_id2 AND int_misc_code.code_id = #tmp_starter_set.int_id3

  UPDATE int_misc_code
  SET    int_keystone_cd = to_lang
  FROM   #TMP_STARTER_SET
  WHERE  set_type_cd = 'S5N-U' AND int_misc_code.code_id = #tmp_starter_set.int_id1 AND int_misc_code.code_id = #tmp_starter_set.int_id2 AND int_misc_code.code_id = #tmp_starter_set.int_id3

  --*******  End of Additions on 30 June 2006 for Localization  ********

  --*******  Added the query below on 12 July 2006 for Localization  ********
  UPDATE int_misc_code
  SET    short_dsc = to_lang
  FROM   #TMP_STARTER_SET
  WHERE  set_type_cd = 'SLOG' AND int_misc_code.code_id = #tmp_starter_set.int_id1 AND int_misc_code.code_id = #tmp_starter_set.int_id2 AND int_misc_code.code_id = #tmp_starter_set.int_id3

  --*******  End of Additions on 12 July 2006 for Localization  ********

  --*******Added the Query below on 28 July 2006 for Localizing the Organization structure**********
  UPDATE int_organization
  SET    organization_nm = to_lang
  FROM   #TMP_STARTER_SET
  WHERE  set_type_cd = 'ORG' AND int_organization.organization_id = #tmp_starter_set.guid

  --******************************************************************************

  /* int_test_group */
  UPDATE int_test_group
  SET    node_name = IsNull( to_lang,
                             '' )
  FROM   #TMP_STARTER_SET
  WHERE  set_type_cd = 'TG' AND #tmp_starter_set.int_id1 = int_test_group.node_id

  /* int_test_group_detail */
  UPDATE int_test_group_detail
  SET    nm = IsNull( to_lang,
                      '' )
  FROM   #TMP_STARTER_SET
  WHERE  set_type_cd = 'TGD' AND #tmp_starter_set.int_id1 = int_test_group_detail.node_id AND IsNull( #tmp_starter_set.int_id2,
                     -999 ) = IsNull( int_test_group_detail.univ_svc_cid,
                                      -999 ) AND IsNull( #tmp_starter_set.int_id3,
                     -999 ) = IsNull( int_test_group_detail.test_cid,
                                      -999 )

  UPDATE int_misc_code
  SET    short_dsc = IsNull( to_lang,
                             '' )
  FROM   #TMP_STARTER_SET
  WHERE  set_type_cd = 'TGD' AND #tmp_starter_set.int_id2 = int_misc_code.code_id AND #tmp_starter_set.int_id3 IS NULL AND int_misc_code.category_cd = 'USID'

  UPDATE int_misc_code
  SET    short_dsc = IsNull( to_lang,
                             '' )
  FROM   #TMP_STARTER_SET
  WHERE  set_type_cd = 'TGD' AND #tmp_starter_set.int_id2 IS NULL AND #tmp_starter_set.int_id3 = int_misc_code.code_id AND int_misc_code.category_cd = 'ATST'

  /* order group */
  UPDATE int_order_group
  SET    node_name = IsNull( to_lang,
                             '' )
  FROM   #TMP_STARTER_SET
  WHERE  set_type_cd = 'OG' AND #tmp_starter_set.int_id1 = int_order_group.node_id

  /* order_group_detail - just update usids */
  UPDATE int_misc_code
  SET    short_dsc = IsNull( to_lang,
                             '' )
  FROM   #TMP_STARTER_SET
  WHERE  set_type_cd = 'OGD' AND #tmp_starter_set.int_id1 = int_misc_code.code_id AND int_misc_code.category_cd = 'USID'

  /* site_link */
  UPDATE int_site_link
  SET    group_name = IsNull( to_lang,
                              '' )
  FROM   #TMP_STARTER_SET
  WHERE  set_type_cd = 'SLG' AND #tmp_starter_set.int_id1 = int_site_link.group_rank

  UPDATE int_site_link
  SET    display_name = IsNull( to_lang,
                                '' )
  FROM   #TMP_STARTER_SET
  WHERE  set_type_cd = 'SL' AND #tmp_starter_set.guid = int_site_link.link_id

  /* environments - int_environment */
  UPDATE int_environment
  SET    display_name = IsNull( to_lang,
                                '' )
  FROM   #TMP_STARTER_SET
  WHERE  set_type_cd = 'EL' AND #tmp_starter_set.guid = int_environment.env_id

  DROP TABLE #TMP_STARTER_SET


