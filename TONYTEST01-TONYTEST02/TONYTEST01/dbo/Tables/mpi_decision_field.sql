﻿CREATE TABLE [dbo].[mpi_decision_field] (
    [candidate_id] UNIQUEIDENTIFIER NOT NULL,
    [matched_id]   UNIQUEIDENTIFIER NOT NULL,
    [field_id]     INT              NOT NULL,
    [score]        TINYINT          NOT NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [decision_field_pkey]
    ON [dbo].[mpi_decision_field]([candidate_id] ASC, [matched_id] ASC, [field_id] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores the results of the score for each field for each decision_log row. These scores are combined to create a total score that is stored in the decision_log record.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'mpi_decision_field';
