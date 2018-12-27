﻿CREATE TABLE [dbo].[int_product_access] (
    [product_cd]      VARCHAR (25)     NOT NULL,
    [organization_id] BIGINT NULL,
    [license_no]      VARCHAR (120)    NULL,
    CONSTRAINT [FK_int_product_access_int_organization_organization_id] FOREIGN KEY ([organization_id]) REFERENCES [dbo].[int_organization] ([organization_id])
);


GO
CREATE UNIQUE CLUSTERED INDEX [CL_int_product_access_product_cd_organization_id]
    ON [dbo].[int_product_access]([product_cd] ASC, [organization_id] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores the product access information.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_product_access';
