create or replace view DW_PROD.REPORT.VW_REGION_BRANCH_KEY_MAPPING(
	REGION_NAME,
	REGION_NUMBER,
	DISPLAY_REGION_NAME,
	DISPLAY_REGION_NUMBER,
	BRANCH_KEY,
	BRANCH_NAME
) as 
SELECT DISTINCT REGION_NAME,REGION_NUMBER ,
CASE WHEN REGION_NAME ='ILLINOIS - SOUTH SUBURBS' THEN 'ILLINOIS - COOK COUNTY'
WHEN REGION_NAME ='ILLINOIS - CHICAGO' THEN 'ILLINOIS - COOK COUNTY'
WHEN REGION_NAME ='ILLINOIS - SOUTH COOK' THEN 'ILLINOIS - COOK COUNTY'
WHEN REGION_NAME ='ILLINOIS - CENTRAL COOK' THEN 'ILLINOIS - COOK COUNTY'
WHEN REGION_NAME ='ILLINOIS - NORTHERN SUBURBS' THEN 'ILLINOIS - COOK COUNTY'
WHEN REGION_NAME ='ILLINOIS - NORTHWEST' THEN 'ILLINOIS - NORTH' ELSE REGION_NAME END DISPLAY_REGION_NAME,
CASE WHEN REGION_NAME ='ILLINOIS - CENTRAL' THEN 3
WHEN REGION_NAME ='ILLINOIS - CENTRAL COOK' OR REGION_NAME ='ILLINOIS - SOUTH COOK'
OR REGION_NAME ='ILLINOIS - CHICAGO' OR REGION_NAME = 'ILLINOIS - SOUTH SUBURBS'
OR REGION_NAME ='ILLINOIS - NORTHERN SUBURBS'THEN 4
WHEN REGION_NAME ='ILLINOIS - NORTHWEST' OR REGION_NAME = 'ILLINOIS - NORTH' THEN 5
WHEN REGION_NAME ='ILLINOIS - SOUTH' THEN 6 ELSE REGION_NUMBER END DISPLAY_REGION_NUMBER,
BRANCH_KEY , BRANCH_NAME
FROM HAH.DIM_BRANCH WHERE SYSTEM_CODE ='IL' AND SOURCE_SYSTEM_ID =3;