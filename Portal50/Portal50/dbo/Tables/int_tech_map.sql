CREATE TABLE [dbo].[int_tech_map] (
    [tech_id]         UNIQUEIDENTIFIER NOT NULL,
    [tech_xid]        NVARCHAR (30)    NOT NULL,
    [organization_id] UNIQUEIDENTIFIER NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [xid_ndx]
    ON [dbo].[int_tech_map]([tech_xid] ASC, [organization_id] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [pkey_ndx]
    ON [dbo].[int_tech_map]([tech_id] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table maps technicians (lab technicians, x-ray techs, etc). All technicians in HL/7 messages have codes or ID''s that identify them. This table maps the external code to an internal person_id.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_tech_map';

