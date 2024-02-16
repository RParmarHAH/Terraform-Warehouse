CREATE OR REPLACE PROCEDURE DISC_PROD.TRUSTPOINTDATA.GET_EMP_MATCH_TRUSTPOINTDATACOASTAL("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
INSERT OVERWRITE INTO DISC_DEDUPE_DEV.TRUSTPOINTDATA.EMP_MATCH_TRUSTPOINTDATACOASTAL
WITH DEDUPE_RECORD_IDS AS 
(
	SELECT RECORD_ID,CLUSTER_ID,FILENAME
	FROM DISC_DEDUPE_DEV.TRUSTPOINTDATA.TRUSTPOINTDATAcoastal_EMP_DEDUPE_SOURCE
	WHERE 
	CLUSTER_ID IN (SELECT CLUSTER_ID
		FROM DISC_DEDUPE_DEV.TRUSTPOINTDATA.TRUSTPOINTDATAcoastal_EMP_DEDUPE_SOURCE
		GROUP BY CLUSTER_ID
		HAVING COUNT(CLUSTER_ID)>1)
),
CLIENT_MASTER AS
(
	SELECT RECORD_ID,CLUSTER_ID,FILENAME,EMPLOYEE.EMPLOYEE_NUMBER
	,ROW_NUMBER() OVER(PARTITION BY DEDUPE.CLUSTER_ID ORDER BY  
		 EMPLOYEE.EMPLOYEE_NUMBER  ) LEAST_RECORD_ID
	FROM DISC_DEDUPE_DEV.TRUSTPOINTDATA.TRUSTPOINTDATAcoastal_EMP_DEDUPE_SOURCE DEDUPE
	INNER JOIN DISC_DEV.TRUSTPOINTDATA.EMPLOYEES EMPLOYEE ON
	DEDUPE.RECORD_ID = EMPLOYEE.EMPLOYEE_NUMBER AND EMPLOYEE.COMPANY =''COASTAL''
) --SELECT * FROM CLIENT_MASTER;
	SELECT M.RECORD_ID  MASTER_ID 
		,DEDUPE.CLUSTER_ID
		,EMPLOYEE.EMPLOYEE_NUMBER
		,ROW_NUMBER() OVER(PARTITION BY DEDUPE.CLUSTER_ID ORDER BY EMPLOYEE.EMPLOYEE_NUMBER ) RECORD_ORDER
		,EMPLOYEE.EMPLOYEE_SSN
		,EMPLOYEE.EMPLOYEE_DOB
		,EMPLOYEE.EMPLOYEE_FIRST_NAME
		,EMPLOYEE.EMPLOYEE_LAST_NAME
		,EMPLOYEE.EMPLOYEE_ADDRESS1
		,EMPLOYEE.EMPLOYEE_CITY
		,EMPLOYEE.EMPLOYEE_ZIP
		,EMPLOYEE.EMPLOYEE_HOME_PHONE
		,EMPLOYEE.PRIMARY_EMAIL
 		FROM DISC_DEDUPE_DEV.TRUSTPOINTDATA.TRUSTPOINTDATAcoastal_EMP_DEDUPE_SOURCE DEDUPE
      INNER JOIN DISC_DEV.TRUSTPOINTDATA.EMPLOYEES EMPLOYEE ON
            DEDUPE.RECORD_ID = EMPLOYEE.EMPLOYEE_NUMBER AND EMPLOYEE.COMPANY =''COASTAL''
      INNER JOIN DEDUPE_RECORD_IDS MATCHES ON
            MATCHES.FILENAME = DEDUPE.FILENAME
            AND MATCHES.RECORD_ID = DEDUPE.RECORD_ID
            AND MATCHES.CLUSTER_ID = DEDUPE.CLUSTER_ID
      INNER JOIN CLIENT_MASTER M ON 
            M.CLUSTER_ID=MATCHES.CLUSTER_ID
            AND LEAST_RECORD_ID=1 
            ORDER BY 2,3;
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    ';