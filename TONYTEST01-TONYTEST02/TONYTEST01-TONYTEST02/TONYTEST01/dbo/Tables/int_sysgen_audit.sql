CREATE TABLE [dbo].[int_sysgen_audit] (
    [audit_dt] DATETIME      NOT NULL,
    [audit]    VARCHAR (255) NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores the system licensing information.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_sysgen_audit';

