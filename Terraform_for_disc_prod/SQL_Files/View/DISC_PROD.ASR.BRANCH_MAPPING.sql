create or replace view DISC_PROD.ASR.BRANCH_MAPPING(
	OLD_LOCATION_ID,
	OLD_LOCATION_NAME,
	NEW_LOCATION_NAME,
	NEW_LOCATION_ID,
	IS_ASR_BRANCH
) as 
(
WITH BRANCH AS (
SELECT 
    LOCATIONID,
    LOCATIONNAME, 
    CASE 
        WHEN TRIM(UPPER(LOCATIONNAME)) LIKE '%CONTRACTORS' OR TRIM(UPPER(LOCATIONNAME)) LIKE '%OFFICE' OR TRIM(UPPER(LOCATIONNAME))LIKE '%SKILLED' THEN TRIM(REGEXP_REPLACE(UPPER(LOCATIONNAME),'SKILLED|CONTRACTORS|OFFICE'))
        ELSE UPPER(TRIM(LOCATIONNAME))
    END AS CLUBBED_LOCATIONS
FROM ASR.ASR_LOCATIONS
)
SELECT
    B.LOCATIONID AS OLD_LOCATION_ID,
    B.LOCATIONNAME AS OLD_LOCATION_NAME,
    IFF(B.CLUBBED_LOCATIONS ='WCH','WASHINGTON CH',B.CLUBBED_LOCATIONS) AS NEW_LOCATION_NAME,
    FIRST_VALUE(B.LOCATIONID) OVER (PARTITION BY NEW_LOCATION_NAME ORDER BY UPPER(B.LOCATIONNAME)) AS NEW_LOCATION_ID
    ,CASE WHEN B.LOCATIONID IN (4,5,12,13,15) THEN FALSE ELSE TRUE END AS IS_ASR_BRANCH
FROM BRANCH B
ORDER BY UPPER(B.LOCATIONNAME)
);