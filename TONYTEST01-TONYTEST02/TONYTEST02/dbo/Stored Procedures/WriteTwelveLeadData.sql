﻿
CREATE PROCEDURE [dbo].[WriteTwelveLeadData]
  (
  @PatientID      VARCHAR(256),
  @ReportID       VARCHAR(256),
  @ReportDT       DATETIME,
  @VersionNumber  SMALLINT,
  @PatientName    VARCHAR(50),
  @IdNum          VARCHAR(20),
  @Birthdate      VARCHAR(15),
  @Age            VARCHAR(15),
  @Sex            VARCHAR(1),
  @Height         VARCHAR(15),
  @Weight         VARCHAR(15),
  @ReportDate     VARCHAR(15),
  @ReportTime     VARCHAR(15),
  @VentRate       INT,
  @PRInterval     INT,
  @QT             INT,
  @QTC            INT,
  @QRSDuration    INT,
  @PAxis          INT,
  @QRSAxis        INT,
  @TAxis          INT,
  @Interpretation NVARCHAR(MAX),
  @SampleRate     INT,
  @SampleCount    INT,
  @NumYPoints     INT,
  @Baseline       INT,
  @YPointsPerUnit INT,
  @WaveformData   IMAGE
  )
AS
  BEGIN
    INSERT INTO int_12lead_report_new
                (patient_id,
                 report_id,
                 report_dt,
                 version_number,
                 patient_name,
                 id_number,
                 birthdate,
                 age,
                 sex,
                 height,
                 weight,
                 report_date,
                 report_time,
                 vent_rate,
                 pr_interval,
                 qt,
                 qtc,
                 qrs_duration,
                 p_axis,
                 qrs_axis,
                 t_axis,
                 interpretation,
                 sample_rate,
                 sample_count,
                 num_YPoints,
                 baseline,
                 YPoints_per_unit,
                 waveform_data)
    VALUES      (@PatientID,
                 @ReportID,
                 @ReportDT,
                 @VersionNumber,
                 @PatientName,
                 @IdNum,
                 @Birthdate,
                 @Age,
                 @Sex,
                 @Height,
                 @Weight,
                 @ReportDate,
                 @ReportTime,
                 @VentRate,
                 @PRInterval,
                 @QT,
                 @QTC,
                 @QRSDuration,
                 @PAxis,
                 @QRSAxis,
                 @TAxis,
                 @Interpretation,
                 @SampleRate,
                 @SampleCount,
                 @NumYPoints,
                 @Baseline,
                 @YPointsPerUnit,
                 @WaveformData)
  END


