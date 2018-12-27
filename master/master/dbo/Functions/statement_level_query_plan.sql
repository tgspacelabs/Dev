
-- DROP FUNCTION [statement_level_query_plan]
CREATE FUNCTION [statement_level_query_plan]
    (
     @handle AS VARBINARY(64) -- Handle for the overall query plan
    )
RETURNS TABLE
    AS
RETURN
    (SELECT
        [x].[statement_nbr],                -- Sequential number of statement within batch or SP
        [x].[statement_type],               -- SELECT, INSERT, UPDATE, etc
        [x].[statement_subtree_cost],       -- Estimated Query Cost
        [x].[statement_estimated_rows],     -- Estimated Rows Returned
        [x].[statement_optimization_level], -- FULL or TRIVIAL
        [x].[statement_text],               -- Text of query
        [x].[statement_plan]                -- XML Plan    To view as a graphical plan
                                            --      save the column output to a file with extension .SQLPlan
                                            --      then reopen the file by double-clicking
     FROM
        (SELECT
            [C].[value]('@StatementId', 'int') AS [statement_nbr],
            [C].[value]('(./@StatementText)', 'nvarchar(max)') AS [statement_text],
            [C].[value]('(./@StatementType)', 'varchar(20)') AS [statement_type],
            [C].[value]('(./@StatementSubTreeCost)', 'float') AS [statement_subtree_cost],
            [C].[value]('(./@StatementEstRows)', 'float') AS [statement_estimated_rows],
            [C].[value]('(./@StatementOptmLevel)', 'varchar(20)') AS [statement_optimization_level],
            -- Construct the XML headers around the single plan that will permit
            -- this column to be used as a graphical showplan.
            -- Only generate plan columns where statement has an associated plan
            [C].[query]('declare namespace PLN="http://schemas.microsoft.com/sqlserver/2004/07/showplan";
                       if (./PLN:QueryPlan or ./PLN:Condition/PLN:QueryPlan)
                       then
                               <PLN:ShowPlanXML><PLN:BatchSequence><PLN:Batch><PLN:Statements><PLN:StmtSimple>
                              { ./attribute::* }
                              { ./descendant::PLN:QueryPlan[1] }
                               </PLN:StmtSimple></PLN:Statements></PLN:Batch></PLN:BatchSequence></PLN:ShowPlanXML>
                       else ()
               ') AS [statement_plan]
         FROM
            [sys].[dm_exec_query_plan](@handle)
            CROSS APPLY -- This expression finds all nodes containing attribute StatementText
            -- regardless of how deep they are in the potentially nested batch hierarchy
            -- The results of this expression are processed by the Select expressions above
            [query_plan].[nodes]('declare namespace PLN="http://schemas.microsoft.com/sqlserver/2004/07/showplan";
                /PLN:ShowPlanXML/PLN:BatchSequence/PLN:Batch/PLN:Statements/descendant::*[attribute::StatementText]') AS [T] ([C])
        ) AS [x]
    );
