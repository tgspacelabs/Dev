CREATE TABLE [dbo].[BlitzIndex] (
    [Customer]                                              VARCHAR (50)   NULL,
    [RunDate]                                               DATE           NULL,
    [Priority]                                              FLOAT (53)     NULL,
    [Finding]                                               NVARCHAR (500) NULL,
    [Details: schema#table#index(indexid)]                  NVARCHAR (500) NULL,
    [Definition: (Property) ColumnName {datatype maxbytes}] NVARCHAR (500) NULL,
    [Secret Columns]                                        NVARCHAR (500) NULL,
    [Usage]                                                 NVARCHAR (500) NULL,
    [Size]                                                  NVARCHAR (500) NULL,
    [More Info]                                             NVARCHAR (500) NULL,
    [URL]                                                   NVARCHAR (500) NULL,
    [Create TSQL]                                           NVARCHAR (MAX) NULL
);

