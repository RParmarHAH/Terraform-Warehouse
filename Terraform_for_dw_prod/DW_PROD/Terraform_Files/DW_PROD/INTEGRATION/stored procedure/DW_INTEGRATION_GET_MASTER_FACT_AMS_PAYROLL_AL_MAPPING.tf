resource "snowflake_procedure" "DW_INTEGRATION_GET_MASTER_FACT_AMS_PAYROLL_AL_MAPPING" {
	name ="GET_MASTER_FACT_AMS_PAYROLL_AL_MAPPING"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
    INSERT INTO DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_AMS_PAYROLL_MAPPING
    WITH MAPPING_DATA AS (
      SELECT * FROM (
        SELECT *,COUNT(DISTINCT SOURCE_SYSTEM) OVER(PARTITION BY CLUSTER_ID) SYSTEM_COUNT
        FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.AMS_PAYROLL_AL_DEDUPE_OUTPUT) 
        WHERE SYSTEM_COUNT > 1
      )
--       SELECT * FROM MAPPING_DATA;
      , AMS_RECORDS AS (
        SELECT * FROM (
          SELECT 
            ROW_NUMBER() OVER(PARTITION BY CLUSTER_ID ORDER BY EMPLOYEE_LAST_CHECK_DATE DESC NULLS LAST, EMPLOYEE_FIRST_CHECK_DATE DESC NULLS LAST, EMPLOYEE_LAST_WORKED_DATE DESC NULLS LAST, EMPLOYEE_TERMINATE_DATE DESC NULLS LAST, EMPLOYEE_HIRE_DATE DESC NULLS LAST) RN, ID AS EMPLOYEE_KEY,EMPLOYEE_ID,SYSTEM_CODE,SOURCE_SYSTEM_ID,NAME,EMPLOYEE_FIRST_NAME,EMPLOYEE_LAST_NAME,EMPLOYEE_PID,EMPLOYEE_DOB,EMPLOYEE_HOME_PHONE,EMPLOYEE_CELL_PHONE,EMPLOYEE_WORK_PHONE,EMPLOYEE_PERSONAL_EMAIL,EMPLOYEE_WORK_EMAIL,EMPLOYEE_ADDRESS1,EMPLOYEE_ADDRESS2,EMPLOYEE_CITY,EMPLOYEE_STATE_CODE,EMPLOYEE_ZIP,EMPLOYEE_NUMBER,EMPLOYEE_HIRE_DATE,EMPLOYEE_FIRST_CHECK_DATE,EMPLOYEE_LAST_CHECK_DATE,EMPLOYEE_LAST_WORKED_DATE,EMPLOYEE_TERMINATE_DATE,PAYROLL_ID,WORK_STATE,ETL_INSERTED_DATE,ETL_LAST_UPDATED_DATE,SOURCE_SYSTEM,CLUSTER_ID
          FROM MAPPING_DATA
          WHERE SOURCE_SYSTEM = ''AMS'' AND CLUSTER_ID IS NOT NULL --AND CLUSTER_ID = 1630.0
        ) WHERE RN = 1
      ) 
--       SELECT COUNT(DISTINCT CLUSTER_ID) FROM AMS_RECORDS
--       UNION ALL 
--       SELECT COUNT(*) FROM AMS_RECORDS;
      , PAYROLL_RECORDS AS (
        SELECT * FROM (
          SELECT 
            ROW_NUMBER() OVER(PARTITION BY CLUSTER_ID ORDER BY EMPLOYEE_LAST_CHECK_DATE DESC NULLS LAST, EMPLOYEE_FIRST_CHECK_DATE DESC NULLS LAST, EMPLOYEE_LAST_WORKED_DATE DESC NULLS LAST, EMPLOYEE_TERMINATE_DATE DESC NULLS LAST, EMPLOYEE_HIRE_DATE DESC NULLS LAST) RN, ID AS EMPLOYEE_KEY,EMPLOYEE_ID,SYSTEM_CODE,SOURCE_SYSTEM_ID,NAME,EMPLOYEE_FIRST_NAME,EMPLOYEE_LAST_NAME,EMPLOYEE_PID,EMPLOYEE_DOB,EMPLOYEE_HOME_PHONE,EMPLOYEE_CELL_PHONE,EMPLOYEE_WORK_PHONE,EMPLOYEE_PERSONAL_EMAIL,EMPLOYEE_WORK_EMAIL,EMPLOYEE_ADDRESS1,EMPLOYEE_ADDRESS2,EMPLOYEE_CITY,EMPLOYEE_STATE_CODE,EMPLOYEE_ZIP,EMPLOYEE_NUMBER,EMPLOYEE_HIRE_DATE,EMPLOYEE_FIRST_CHECK_DATE,EMPLOYEE_LAST_CHECK_DATE,EMPLOYEE_LAST_WORKED_DATE,EMPLOYEE_TERMINATE_DATE,PAYROLL_ID,WORK_STATE,ETL_INSERTED_DATE,ETL_LAST_UPDATED_DATE,SOURCE_SYSTEM,CLUSTER_ID
          FROM MAPPING_DATA
          WHERE SOURCE_SYSTEM = ''PAYROLL'' AND CLUSTER_ID IS NOT NULL
        ) WHERE RN = 1
      )
--       SELECT COUNT(DISTINCT CLUSTER_ID) FROM PAYROLL_RECORDS
--       UNION ALL 
--       SELECT COUNT(*) FROM PAYROLL_RECORDS;
--       SELECT * FROM AMS_RECORDS WHERE CLUSTER_ID NOT IN (SELECT CLUSTER_ID FROM PAYROLL_RECORDS);
      SELECT
        A.EMPLOYEE_KEY AS AMS_EMPLOYEE_KEY, 
        P.EMPLOYEE_KEY AS PAYROLL_EMPLOYEE_KEY,
        A.EMPLOYEE_ID AS AMS_EMPLOYEE_ID,
        P.EMPLOYEE_ID AS PAYROLL_EMPLOYEE_ID,
        A.SYSTEM_CODE AS AMS_SYSTEM_CODE,
        P.SYSTEM_CODE AS PAYROLL_SYSTEM_CODE,
        A.SOURCE_SYSTEM_ID::INT AS AMS_SOURCE_SYSTEM_ID,
        P.SOURCE_SYSTEM_ID::INT AS PAYROLL_SOURCE_SYSTEM_ID,
        A.EMPLOYEE_HIRE_DATE AS AMS_HIRE_DATE,
        P.EMPLOYEE_HIRE_DATE AS PAYROLL_HIRE_DATE,
        A.EMPLOYEE_TERMINATE_DATE AS AMS_TERMINATE_DATE,
        P.EMPLOYEE_TERMINATE_DATE AS PAYROLL_TERMINATE_DATE,
        A.ETL_INSERTED_DATE AS AMS_INSERTED_DATE,
        P.ETL_INSERTED_DATE AS PAYROLL_INSERTED_DATE,
        A.ETL_LAST_UPDATED_DATE AS AMS_LAST_UPDATED_DATE,
        P.ETL_LAST_UPDATED_DATE AS PAYROLL_LAST_UPDATED_DATE
      FROM AMS_RECORDS A INNER JOIN PAYROLL_RECORDS P ON A.CLUSTER_ID = P.CLUSTER_ID;
    SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}

