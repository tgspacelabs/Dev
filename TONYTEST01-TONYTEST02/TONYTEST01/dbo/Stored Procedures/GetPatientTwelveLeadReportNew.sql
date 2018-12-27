
CREATE PROCEDURE [dbo].[GetPatientTwelveLeadReportNew]
  (
  @patient_id UNIQUEIDENTIFIER,
  @report_id  UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT TLRN.report_id,
           TLRN.report_dt,
           TLRN.version_number,
           TLRN.patient_name,
           TLRN.id_number,
           TLRN.birthdate,
           TLRN.age,
           TLRN.sex,
           TLRN.height,
           TLRN.weight,
           TLRN.report_date,
           TLRN.report_time,
           TLRN.vent_rate,
           TLRN.pr_interval,
           TLRN.qt,
           TLRN.qtc,
           TLRN.qrs_duration,
           TLRN.p_axis,
           TLRN.qrs_axis,
           TLRN.t_axis,
           TLRN.interpretation,
           TLRN.interpretation_edits,
           USR.user_id,
           USR.login_name,
           TLRN.sample_rate,
           TLRN.sample_count,
           TLRN.num_Ypoints,
           TLRN.baseline,
           TLRN.Ypoints_per_unit,
           TLRN.waveform_data,
           TLRN.send_request,
           TLRN.send_complete,
           TLRN.send_dt
    FROM   dbo.int_12lead_report_new TLRN
           LEFT OUTER JOIN int_user USR
             ON USR.user_id = TLRN.user_id
    WHERE  ( TLRN.patient_id = @patient_id ) AND ( TLRN.report_id = @report_id )
  END

