create or replace view DW_PROD.HAH.VW_DIM_SOURCE_SYSTEM_TO_MARKET(
	SOURCE_SYSTEM_ID,
	SYSTEM_CODE,
	SOURCE_SYSTEM,
	SOURCE_SYSTEM_TYPE,
	MARKET
) as
SELECT DISTINCT emp.Source_System_ID, emp.SYSTEM_Code, 
       CASE WHEN ss.System_Code = 'CostalSyncData' AND emp.Source_System_ID IN (1,2) THEN 'Carevoyant'
            WHEN ss.System_Code = 'CostalSyncData' AND emp.Source_System_ID IN (11) THEN 'Coastal Great Plains'
            WHEN ss.System_Code = 'DataFlexSyncData' THEN 'DataFlex'
            WHEN ss.System_Code = 'SandataImport' THEN 'Sandata'
            WHEN ss.System_Code = 'GPSyncData' THEN 'Great Plains'
            WHEN ss.System_Code = 'TrustPointData' THEN 'Trustpoint'
            WHEN ss.System_Code = 'CCSI' THEN 'CCSI - Filepro'
            WHEN ss.System_Code = 'PAYLOCITY' THEN 'Paylocity'
            WHEN ss.System_Code = 'VIVENTIUM' THEN 'Viventium'
            WHEN ss.Source_System_ID = 9 THEN 'Alayacare'
            WHEN ss.Source_System_ID = 17 THEN 'HHAExchange'
            ELSE ss.System_Code
       END AS Source_System,
       ss.Source_System_Type,
--       emp.SYSTEM_Code,
       CASE WHEN emp.System_Code LIKE '%ALTRU%' THEN 'GA - Altrus'
            WHEN emp.System_Code LIKE '%SAVANNAH%' THEN 'GA - Coastal'
            WHEN emp.System_Code LIKE '%SHC%' THEN 'GA - Coastal'
            WHEN emp.System_Code LIKE '%8485%' THEN 'PA'
            WHEN emp.System_Code LIKE '%ANSWER%' THEN 'OH - AnswerCare'
            WHEN emp.System_Code LIKE '%COORD%' THEN 'Care Coordination'
            WHEN emp.System_Code LIKE '%COASTAL%' THEN 'GA - Coastal'
            WHEN emp.System_Code LIKE '%EXCEL%' THEN 'PA - Excel'
            WHEN emp.System_Code LIKE '%DELAWARE%' THEN 'DE'
            WHEN emp.System_Code LIKE '%HAHMI%' THEN 'MI'
            WHEN emp.System_Code LIKE '%PRIMEHHA%' THEN 'OH - HHA'
            WHEN emp.System_Code LIKE '%PRIMEMIDWAY%' THEN 'OH - Midway'
            WHEN emp.System_Code LIKE '%PRIME%' AND emp.Source_System_ID IN (6, 13, 14, 31) THEN 'OH - Prime'
            WHEN emp.System_Code LIKE '%MATRIX%' THEN 'IN & MI'
            WHEN emp.System_Code LIKE '%CCSI%' THEN 'IL'
            WHEN emp.System_Code LIKE '%3554%' THEN 'AL'
            WHEN emp.System_Code LIKE '%1002%' THEN 'GA'
            WHEN emp.System_Code LIKE '%6150%' THEN 'IN'
            WHEN emp.System_Code LIKE '%CLEARCARE%' THEN 'OH - AnswerCare'
            WHEN emp.System_Code LIKE '%PREFER%' AND emp.Source_System_ID = 17 THEN 'NY - Preferred'
            WHEN emp.System_Code LIKE '%EDISON%' AND emp.Source_System_ID = 17 THEN 'NY - Edison'
            WHEN emp.System_Code LIKE '%ALLIANCE%' THEN 'MI'
            WHEN emp.System_Code LIKE '%NAVISION%' THEN 'IL'
            WHEN emp.System_Code LIKE '%OPEN%DE%' THEN 'DE - HHA1'
            WHEN emp.System_Code LIKE '%OPEN%PA%' THEN 'PA - HHA1'
            WHEN emp.System_Code LIKE '%OPEN%MS%' THEN 'MS - HHA1'
            WHEN emp.System_Code LIKE '%OSHAH%DE%' THEN 'DE - HHA2'
            WHEN emp.System_Code LIKE '%OSHAH%PA%' THEN 'PA - HHA2'
            WHEN emp.System_Code LIKE '%OSHAH%MS%' THEN 'MS - HHA2'
            ELSE emp.System_Code
       END AS Market
FROM DW_PROD.HAH.DIM_Employee AS emp
INNER JOIN DW_PROD.HAH.DIM_Source_System AS ss ON emp.Source_System_ID = ss.Source_System_ID
UNION
SELECT DISTINCT 4 AS Source_System_ID, AgencyID AS System_Code, 'Sandata' AS Source_System, 'AMS' AS Source_System_Type,
       CASE WHEN AgencyID = 5841 THEN 'TN'
            WHEN AgencyID = 8380 THEN 'IL'
            WHEN AgencyID = 8463 THEN 'MO'
            WHEN AgencyID = 38004 THEN 'IN'
            WHEN AgencyID = 38005 THEN 'MI'
            ELSE AgencyID
       END AS Market
FROM DISC_Prod.SandataImport.Sandata_Staffs
WHERE AgencyID NOT IN (8485)
ORDER BY 1, 3, 2, 5;