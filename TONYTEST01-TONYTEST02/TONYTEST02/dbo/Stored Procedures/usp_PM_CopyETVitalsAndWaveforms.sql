
--====================================================================================================================
--=================================================usp_PM_CopyETVitalsAndWaveforms==================================
-----------------------------------------------------------------------------------------------
-- =======================================================================
-- Purpose: Copies all alarm, vitals, and waveform data relating to ET alarms for printing and reprinting. Used by the ICS_PrintJobDataCopier SqlAgentJob.
-- =======================================================================
CREATE PROCEDURE [dbo].[usp_PM_CopyETVitalsAndWaveforms]
AS
BEGIN TRANSACTION
EXEC [dbo].usp_PM_CopyETWaveformData
EXEC [dbo].usp_PM_CopyETVitalsData
COMMIT TRANSACTION

