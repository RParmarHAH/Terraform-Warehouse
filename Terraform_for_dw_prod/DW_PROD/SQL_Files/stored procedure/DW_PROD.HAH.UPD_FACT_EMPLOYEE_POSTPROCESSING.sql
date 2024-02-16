CREATE OR REPLACE PROCEDURE DW_PROD.HAH.UPD_FACT_EMPLOYEE_POSTPROCESSING("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
--*****************************************************************************************************************************
-- NAME:  UPDATE_EMPLOYEE_KEY
--
-- PURPOSE: Update UPDATE_EMPLOYEE_KEY in FACT_VISIT ,FACT_REVENUE Tables 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 04/28/2023	Darshan Gosai 			Initial development
--*****************************************************************************************************************************


------Update EMPLOYEE_KEY in FACT_REVENUE table When EMPLOYEE_KEY in DIM_EMPLOYEE get change

UPDATE DW_PROD.HAH.FACT_REVENUE R FROM   
(
SELECT
REVENUE.EMPLOYEE_KEY AS EMPLOYEE_KEY,
REVENUE.SYSTEM_CODE  AS SYSTEM_CODE,
EMP_MATCH.MASTER_EMPLOYEE_KEY AS MASTER_EMPLOYEE_KEY,
EMP_MATCH.LATEST_EMPLOYEE_NUMBER AS LATEST_EMPLOYEE_NUMBER
from
DISC_DEDUPE_PROD.PUBLIC.VW_EMPLOYEE_MATCH_LIST EMP_MATCH
JOIN DW_PROD.HAH.DIM_EMPLOYEE EMP ON EMP.EMPLOYEE_KEY = EMP_MATCH.MASTER_EMPLOYEE_KEY
JOIN DW_PROD.HAH.FACT_REVENUE REVENUE ON REVENUE.EMPLOYEE_KEY = EMP_MATCH.EMPLOYEE_KEY
AND REVENUE.EMPLOYEE_KEY <> EMP_MATCH.MASTER_EMPLOYEE_KEY
GROUP BY 1,2,3,4
)X
SET 
R.EMPLOYEE_KEY = X.MASTER_EMPLOYEE_KEY,
R.EMPLOYEE_ID = X.LATEST_EMPLOYEE_NUMBER
WHERE
R.EMPLOYEE_KEY = X.EMPLOYEE_KEY 
AND R.SYSTEM_CODE = X.SYSTEM_CODE ;

---Update EMPLOYEE_KEY in FACT_VISIT table When EMPLOYEE_KEY in DIM_EMPLOYEE get change 


UPDATE DW_PROD.HAH.FACT_VISIT V FROM  
(
SELECT
VISIT.EMPLOYEE_KEY AS EMPLOYEE_KEY,
VISIT.SYSTEM_CODE  AS SYSTEM_CODE,
EMP_MATCH.MASTER_EMPLOYEE_KEY AS MASTER_EMPLOYEE_KEY,
EMP_MATCH.LATEST_EMPLOYEE_NUMBER AS LATEST_EMPLOYEE_NUMBER
FROM
DISC_DEDUPE_PROD.PUBLIC.VW_EMPLOYEE_MATCH_LIST EMP_MATCH
JOIN DW_PROD.HAH.DIM_EMPLOYEE EMP ON EMP.EMPLOYEE_KEY = EMP_MATCH.MASTER_EMPLOYEE_KEY
JOIN DW_PROD.HAH.FACT_VISIT VISIT ON VISIT.EMPLOYEE_KEY = EMP_MATCH.EMPLOYEE_KEY
AND VISIT.EMPLOYEE_KEY <> EMP_MATCH.MASTER_EMPLOYEE_KEY
GROUP BY 1,2,3,4)Y
SET 
V.EMPLOYEE_KEY = Y.MASTER_EMPLOYEE_KEY,
V.EMPLOYEE_ID = Y.LATEST_EMPLOYEE_NUMBER 
WHERE
V.EMPLOYEE_KEY = Y.EMPLOYEE_KEY
AND V.SYSTEM_CODE  = Y.SYSTEM_CODE ;


 RETURN ''SUCCESS'';
    END;
';