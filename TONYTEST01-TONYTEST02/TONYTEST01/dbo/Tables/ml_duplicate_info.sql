CREATE TABLE [dbo].[ml_duplicate_info] (
    [Original_ID]       VARCHAR (20) NOT NULL,
    [Duplicate_Id]      VARCHAR (20) NOT NULL,
    [Original_Monitor]  VARCHAR (5)  NOT NULL,
    [Duplicate_Monitor] VARCHAR (5)  NOT NULL,
    [InsertDT]          DATETIME     CONSTRAINT [DEF_ml_duplicate_info_InsertDT] DEFAULT (getdate()) NOT NULL,
    [duplicate_rec_id]  BIGINT       IDENTITY (0, 1) NOT NULL,
    CONSTRAINT [PK_ml_duplicate_info] PRIMARY KEY CLUSTERED ([Original_ID] ASC, [Duplicate_Id] ASC, [Original_Monitor] ASC, [Duplicate_Monitor] ASC)
);

