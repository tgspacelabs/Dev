﻿CREATE PROCEDURE [dbo].[usp_IcsPrintSvc_GetActivePrintItem]
    (
     @FActivePrintJobId UNIQUEIDENTIFIER,
     @NullBooleanTrue TINYINT
    )
AS
BEGIN
    SELECT
        [print_job_id],
        [page_number],
        [end_of_job_sw]
    FROM
        [dbo].[int_print_job]
    WHERE
        [print_job_id] = @FActivePrintJobId
        AND [print_sw] = @NullBooleanTrue
    ORDER BY
        [page_number];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_IcsPrintSvc_GetActivePrintItem';

