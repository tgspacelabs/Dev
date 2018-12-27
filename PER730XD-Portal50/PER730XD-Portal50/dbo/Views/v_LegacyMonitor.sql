

CREATE VIEW [dbo].[v_LegacyMonitor]
AS
SELECT     
    Id, 
    '6924FE52-54CC-11D3-A454-0060943F44D1' as UnitOrgId,
    'UVN_1' as NetworkId,
    NULL as NodeId,
    NULL as BedId,
    NULL as BedCd,
    NULL as Room,
    NULL as [Description],
    Name as Name,
    'IP_0A' as [Type],
    'SLISH' as Subnet

FROM  [Devices]
