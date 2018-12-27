CREATE TABLE [dbo].[mpi_decision_log] (
    [candidate_id] UNIQUEIDENTIFIER NOT NULL,
    [matched_id]   UNIQUEIDENTIFIER NOT NULL,
    [score]        INT              NOT NULL,
    [mod_dt]       DATETIME         NOT NULL,
    [status_code]  VARCHAR (3)      NULL
);


GO
CREATE NONCLUSTERED INDEX [dl_matched_idx]
    ON [dbo].[mpi_decision_log]([matched_id] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [dl_mod_dt_idx]
    ON [dbo].[mpi_decision_log]([mod_dt] ASC) WITH (FILLFACTOR = 100);


GO
CREATE UNIQUE NONCLUSTERED INDEX [decision_log_pkey]
    ON [dbo].[mpi_decision_log]([candidate_id] ASC, [matched_id] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores the results of scoring for each inexact search. Any patients that score above a certain threshold will cause records to be added to this table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'mpi_decision_log';

