
CREATE PROCEDURE [dbo].[p_cb_Load_Print_Jobs]
  (
  @PrintJobsCrit INT,
  @StartJobDt    VARCHAR(20),
  @EndJobDt      VARCHAR(20),
  @StatusCode    CHAR(1),
  @PrintFlag     CHAR(1),
  @JobType       VARCHAR(25),
  @ShowAuto      CHAR(1)
  )
AS
  BEGIN
    DECLARE @Query VARCHAR(8000)

    SET @Query = 'SELECT 
                     pj.print_job_id,
                     pj.page_number,
                     pj.patient_id,
                     pj.job_net_dt,
                     pj.descr,
                     pj.print_sw,
                     pj.printer_name,
                     pj.status_code,
                     pj.status_msg,
                     mm.mrn_xid,
                     per.first_nm,
                     per.middle_nm,
                     per.last_nm,
                     per.suffix 
                  FROM 
                    int_print_job pj 
                    LEFT OUTER JOIN int_person per ON (pj.patient_id = per.person_id) 
                    LEFT OUTER JOIN int_mrn_map mm ON (pj.patient_id = mm.patient_id) 
                  WHERE 
                    (merge_cd = ''C'') and 
                    page_number = (select max(page_number) 
                                   from int_print_job pj2 
                                   where pj2.print_job_id = pj.print_job_id)'

    IF @PrintJobsCrit <> 0
      BEGIN
        IF @StartJobDt <> ''
          SET @Query = @Query + ' and job_net_dt >= ' + @StartJobDt + ''''

        IF @EndJobDt <> ''
          SET @Query = @Query + ' and job_net_dt < ' + @EndJobDt + ''''

        IF @StatusCode <> ''
          SET @Query = @Query + ' and status_code = ''' + @StatusCode + ''''

        IF @PrintFlag = 'Y'
          SET @Query = @Query + ' and print_sw = 1'
        ELSE IF @PrintFlag = 'N'
          SET @Query = @Query + ' and print_sw = 0'

        IF @JobType <> ''
          SET @Query = @Query + ' and job_type = ''' + @JobType + ''''
        ELSE IF @ShowAuto <> 'Y'
          SET @Query = @Query + ' and job_type <> ''jtAutoAlarm'''
      END

    SET @Query = @Query + ' order by job_net_dt'

    EXEC(@Query)

  END


