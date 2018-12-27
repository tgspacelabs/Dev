
CREATE PROCEDURE [dbo].[p_Node_dIstRib]
  (
  @patient_id UNIQUEIDENTIFIER,
  @node_id    INT = NULL
  )
AS
  DECLARE @level INT

  SET @level = 0

  SET NOCOUNT ON

  CREATE TABLE #TMP_NODES
    (
       node_id        INT,
       rank           INT NULL,
       parent_node_id INT NULL,
       node_name      VARCHAR( 100 ) NULL,
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

  SELECT #tmp_nodes.rank NODERANK,
         #tmp_nodes.node_id,
         #tmp_nodes.node_name,
         int_test_group_detail.rank DETRANK,
         int_test_group_detail.nm,
         int_test_group_detail.display_type,
         'rtTest' TEST_TYPE,
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
         result_value
  INTO   #TMP_RESULTS
  FROM   #TMP_NODES,
         int_test_group_detail,
         int_result
  WHERE  patient_id = @patient_id AND ( ( is_history IS NULL )  OR ( is_history = 0 ) ) AND #tmp_nodes.node_id = int_test_group_detail.node_id AND int_test_group_detail.test_cid = int_result.test_cid
  UNION
  SELECT DISTINCT
         #tmp_nodes.rank NODERANK,
         #tmp_nodes.node_id,
         #tmp_nodes.node_name,
         int_test_group_detail.rank DETRANK,
         int_test_group_detail.nm,
         int_test_group_detail.display_type,
         'rtUsid' TEST_TYPE,
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
         NULL RESULT_VALUE
  FROM   #TMP_NODES,
         int_test_group_detail,
         int_result
  WHERE  patient_id = @patient_id AND ( ( is_history IS NULL )  OR ( is_history = 0 ) ) AND #tmp_nodes.node_id = int_test_group_detail.node_id AND int_test_group_detail.univ_svc_cid = int_result.univ_svc_cid

  SELECT obs_start_dt,
         COUNT(*) CNT
  FROM   #TMP_RESULTS
  GROUP  BY obs_start_dt
  ORDER  BY obs_start_dt DESC

  /*
  select univ_svc_cid, test_cid
  into #tmp_details
  from cdr_test_group_detail, #tmp_nodes
  where cdr_test_group_detail.node_id = #tmp_nodes.node_id
  
  
  
  select obs_start_dt, test_cid, univ_svc_cid, count(*)  cnt
  into #tmp_results
  from int_result
  where patient_id = @patient_id
  and is_history is null
  group by obs_start_dt, test_cid, univ_svc_cid
  
  select obs_start_dt, cnt
  into #tmp_answer
  from  #tmp_results, #tmp_details
  where   #tmp_results.test_cid = #tmp_details.test_cid
  union all
  select obs_start_dt, cnt
  from  #tmp_results, #tmp_details
  where   #tmp_results.univ_svc_cid = #tmp_details.univ_svc_cid
  
  
  set nocount off
  
  select obs_start_dt, sum(cnt) cnt
   from #tmp_answer
  group by (obs_start_dt)
  order by obs_start_dt desc
  
  drop table #tmp_details
  */

  DROP TABLE #TMP_NODES

  DROP TABLE #TMP_RESULTS


