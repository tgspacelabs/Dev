﻿CREATE TABLE [dbo].[Parameter]
(
    [ParameterID] INT NOT NULL CONSTRAINT [PK_Parameter_ParameterID] PRIMARY KEY IDENTITY, 
    [Key] NVARCHAR(50) NOT NULL CONSTRAINT [UQ_Parameter_Key] UNIQUE NONCLUSTERED, 
    [Value] NVARCHAR(100) NOT NULL
)
