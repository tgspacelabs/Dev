
CREATE PROCEDURE [dbo].[p_Node_Results]
  @patient_id UNIQUEIDENTIFIER,
  @min_date   DATETIME,
  @max_date   DATETIME,
  @node_id    INT = NULL
AS
  DECLARE
    @level INT,
    @table VARCHAR(100)

  SET @level = 0

  SET @table = 'int_result'

  SET NOCOUNT OFF

  CREATE TABLE #TMP_NODES
    (
       node_id        INT,
       rank           INT NULL,
       parent_node_id INT NULL,
       node_name      NVARCHAR( 100 ) NULL,
       level          INT
    )

  IF ( @node_id IS NULL )
    BEGIN
      INSERT INTO #TMP_NODES
        SELECT node_id,
               rank,
               parent_node_id,
               node_name,
               @level LEVEL
        FROM   int_test_group
        WHERE  parent_node_id IS NULL
    END
  ELSE
    BEGIN
      INSERT INTO #TMP_NODES
        SELECT node_id,
               rank,
               parent_node_id,
               node_name,
               @level LEVEL
        FROM   int_test_group
        WHERE  node_id = @node_id
    END

  WHILE ( @@ROWCOUNT <> 0 )
    BEGIN
      SET @level = @level + 1

      INSERT INTO #TMP_NODES
        SELECT node_id,
               rank,
               parent_node_id,
               node_name,
               @level
        FROM   int_test_group
        WHERE  parent_node_id IN
               ( SELECT node_id
                 FROM   #TMP_NODES ) AND node_id NOT IN ( SELECT node_id
                                    FROM   #TMP_NODES )
    END

  /*
  select * from int_result
  where patient_id = @patient_id
  and    obs_start_dt <= @max_date
  and    obs_start_dt >= @min_date
  and   ((is_history is null) or (is_history = 0))
  */

  SELECT #tmp_nodes.rank NODERANK,
         #tmp_nodes.node_id,
         #tmp_nodes.node_name,
         alias_test_cid ALIAS,
         int_test_group_detail.source_cid TGD_SOURCE_CID,
         int_test_group_detail.rank DETRANK,
         int_test_group_detail.nm,
         int_test_group_detail.display_type,
         'rtTest' TEST_TYPE,
         int_misc_code.sys_id,
         obs_start_dt,
         order_id,
         int_result.univ_svc_cid,
         int_result.test_cid,
         history_seq,
         test_sub_id,
         order_line_seq_no,
         test_result_seq_no,
         result_dt,
         value_type_cd,
         specimen_id,
         int_result.source_cid,
         status_cid,
         result_units_cid,
         reference_range_id,
         abnormal_cd,
         nsurv_tfr_ind,
         prin_rslt_intpr_id,
         result_value,
         CONVERT ( VARCHAR(10), result_comment ) RESULT_COMMENT
  INTO   #TMP_RESULTS
  FROM   #TMP_NODES,
         int_test_group_detail,
         int_result,
         int_misc_code
  WHERE  patient_id = @patient_id AND obs_start_dt <= @max_date AND obs_start_dt >= @min_date AND ( ( is_history IS NULL )  OR ( is_history = 0 ) ) AND #tmp_nodes.node_id = int_test_group_detail.node_id AND int_test_group_detail.test_cid = int_result.test_cid AND int_result.test_cid = int_misc_code.code_id
  UNION
  SELECT DISTINCT
         #tmp_nodes.rank NODERANK,
         #tmp_nodes.node_id,
         #tmp_nodes.node_name,
         alias_univ_svc_cid ALIAS,
         int_test_group_detail.source_cid TGD_SOURCE_CID,
         int_test_group_detail.rank DETRANK,
         int_test_group_detail.nm,
         int_test_group_detail.display_type,
         'rtUsid' TEST_TYPE,
         int_misc_code.sys_id,
         obs_start_dt,
         order_id,
         int_result.univ_svc_cid,
         NULL TEST_CID,
         history_seq,
         NULL TEST_SUB_ID,
         order_line_seq_no,
         NULL TEST_RESULT_SEQ_NO,
         result_dt,
         NULL VALUE_TYPE_CD,
         specimen_id,
         int_result.source_cid,
         NULL STATUS_CID,
         NULL RESULT_UNITS_CID,
         NULL REFERENCE_RANGE_ID,
         abnormal_cd,
         nsurv_tfr_ind,
         prin_rslt_intpr_id,
         NULL RESULT_VALUE,
         CONVERT( VARCHAR(10), result_comment ) RESULT_COMMENT
  FROM   #TMP_NODES,
         int_test_group_detail,
         int_result,
         int_misc_code
  WHERE  patient_id = @patient_id AND obs_start_dt <= @max_date AND obs_start_dt >= @min_date AND ( ( is_history IS NULL )  OR ( is_history = 0 ) ) AND #tmp_nodes.node_id = int_test_group_detail.node_id AND int_test_group_detail.univ_svc_cid = int_result.univ_svc_cid AND int_result.univ_svc_cid = int_misc_code.code_id

  SELECT DISTINCT
         int_patient_image.order_id,
         1 HAS_IMAGE
  INTO   #TMP_IMAGES
  FROM   #TMP_RESULTS,
         int_patient_image
  WHERE  #tmp_results.order_id = int_patient_image.order_id AND int_patient_image.patient_id = @patient_id

  SELECT #tmp_results.*,
         M1.code SOURCE_CD,
         RR.reference_range,
         PN.last_nm,
         PN.first_nm,
         PN.middle_nm,
         PN.suffix,
         int_order.status_cid ORDER_STATUS_CID,
         has_image,
         int_order.encounter_id
  FROM   #TMP_RESULTS
         LEFT OUTER JOIN int_reference_range RR
           ON ( #tmp_results.reference_range_id = RR.reference_range_id )
         LEFT OUTER JOIN int_misc_code M1
           ON ( #tmp_results.source_cid = M1.code_id )
         LEFT OUTER JOIN int_person_name PN
           ON ( #tmp_results.prin_rslt_intpr_id = PN.person_nm_id )
         LEFT OUTER JOIN int_order
           ON ( #tmp_results.order_id = int_order.order_id )
         LEFT OUTER JOIN #TMP_IMAGES
           ON ( #tmp_results.order_id = #tmp_images.order_id )

  DROP TABLE #TMP_NODES

  DROP TABLE #TMP_RESULTS

  DROP TABLE #TMP_IMAGES


