/*
Post-Deployment Script Template                            
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.        
 Use SQLCMD syntax to include a file in the post-deployment script.            
 Example:      :r .\myfile.sql                                
 Use SQLCMD syntax to reference a variable in the post-deployment script.        
 Example:      :setvar TableName MyTable                            
               SELECT * FROM [$(TableName)]                    
--------------------------------------------------------------------------------------
*/

--USE [DBUnitTest]
--GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[SetParameter]
        @Key = N'RootPath',
        @Value = N'C:\'

SELECT	'Return Value' = @return_value
GO


DECLARE	@return_value int

EXEC	@return_value = [dbo].[SetParameter]
        @Key = N'Owner',
        @Value = N'Tony Green'

SELECT	'Return Value' = @return_value
GO
