
-- [GetHierarchicalOrgsAsXml] is used to get organization structure
CREATE PROCEDURE [dbo].[GetOrganizationDataAsXml]
AS
  BEGIN
         with tree as 
  (
       SELECT org.[organization_id] as id  
    ,org.[parent_organization_id]  as parentid
            ,org.[organization_nm] as name
             ,org.[organization_cd] as description
            ,'ORG' as type
     , 1 as orderby
        FROM [dbo].[int_organization] org where org.parent_organization_id is null

  union
        SELECT facil.[organization_id] as id    
  ,facil.[parent_organization_id]  as parentid
            ,facil.[organization_nm] as name
            ,facil.[organization_cd] as description
            ,'FACILITY' as type 
     , 2 as orderby
        FROM [dbo].[int_organization] org1
        INNER JOIN [dbo].[int_organization] facil on org1.[organization_id]=facil.parent_organization_id and facil.[category_cd]='F' --F:facility

   union
        SELECT  facil2.[organization_id] as id
  ,facil2.[parent_organization_id]    as parentid  
            ,facil2.[organization_nm] as name
            ,facil2.[organization_cd] as description
            ,'UNIT' as type 
     , 3 as orderby
        FROM [dbo].[int_organization] org1
        INNER JOIN [dbo].[int_organization] facil2 on org1.[organization_id]=facil2.parent_organization_id and facil2.[category_cd]='D' and org1.[category_cd]='F' -- F:facility; D-Department
 )

 select * from tree 

 ORDER BY orderby, type
  FOR XML RAW ('orgitem'), ROOT;
  END

