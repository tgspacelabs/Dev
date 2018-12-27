CREATE TABLE [dbo].[int_user_settings] (
    [user_id]       UNIQUEIDENTIFIER NOT NULL,
    [cfg_name]      VARCHAR (40)     NOT NULL,
    [cfg_xml_value] XML              NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_user_settings';

