﻿CREATE TABLE [dbo].[int_param_timetag] (
    [patient_id]         UNIQUEIDENTIFIER NOT NULL,
    [orig_patient_id]    UNIQUEIDENTIFIER NULL,
    [patient_channel_id] UNIQUEIDENTIFIER NOT NULL,
    [timetag_type]       INT              NOT NULL,
    [param_ft]           BIGINT           NOT NULL,
    [param_dt]           DATETIME         NOT NULL,
    [value1]             INT              NULL,
    [value2]             INT              NULL
);


GO
CREATE CLUSTERED INDEX [idxc_int_param_timetag]
    ON [dbo].[int_param_timetag]([patient_id] ASC, [timetag_type] ASC, [param_ft] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ndx_pkey]
    ON [dbo].[int_param_timetag]([patient_id] ASC, [timetag_type] ASC, [patient_channel_id] ASC, [param_ft] ASC);


GO
CREATE NONCLUSTERED INDEX [index_param_timetag]
    ON [dbo].[int_param_timetag]([timetag_type] ASC, [patient_id] ASC, [param_ft] ASC)
    INCLUDE([param_dt], [value1], [value2]);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores time tag events (lead change events and module status events). Each record is uniquely identified by patient_id, param_type, timetag_type, and param_ft. The data in this table is populated by teh MonitorLoader process.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_param_timetag';
