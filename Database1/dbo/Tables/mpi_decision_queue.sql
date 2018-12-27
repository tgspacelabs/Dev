CREATE TABLE [dbo].[mpi_decision_queue] (
    [candidate_id] UNIQUEIDENTIFIER NOT NULL,
    [mod_dt]       DATETIME         NOT NULL,
    [processed_dt] DATETIME         NULL
);


GO
CREATE NONCLUSTERED INDEX [dq_mod_dt_idx]
    ON [dbo].[mpi_decision_queue]([mod_dt] ASC) WITH (FILLFACTOR = 100);


GO
CREATE UNIQUE NONCLUSTERED INDEX [decision_queue_pkey]
    ON [dbo].[mpi_decision_queue]([candidate_id] ASC, [processed_dt] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Patients that needs to be "scored"(i.e. similar patients (if any) need to be located). An MPI search is necessary to be run against this patient. If similar patients are found, then row(s) are inserted into the decision_log table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'mpi_decision_queue';

