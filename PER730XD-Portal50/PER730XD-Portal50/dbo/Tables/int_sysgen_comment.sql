CREATE TABLE [dbo].[int_sysgen_comment] (
    [comment_dt] DATETIME      NOT NULL,
    [comment]    VARCHAR (255) NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores comments about system generation.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_sysgen_comment';

