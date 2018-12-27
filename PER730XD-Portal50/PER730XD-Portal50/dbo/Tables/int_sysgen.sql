CREATE TABLE [dbo].[int_sysgen] (
    [product_cd] VARCHAR (25) NOT NULL,
    [feature_cd] VARCHAR (25) NOT NULL,
    [setting]    VARCHAR (80) NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores the system generation information.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_sysgen';

