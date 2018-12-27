CREATE TABLE [dbo].[int_user_settings] (
    [user_id]       UNIQUEIDENTIFIER NOT NULL,
    [cfg_name]      VARCHAR (40)     NOT NULL,
    [cfg_xml_value] XML              NOT NULL
);

