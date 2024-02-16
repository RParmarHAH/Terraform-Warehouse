resource "snowflake_procedure" "DW_INTEGRATION_GET_MASTER_FACT_PARADOX_EMPLOYEE_MAPPING" {
	name ="GET_MASTER_FACT_PARADOX_EMPLOYEE_MAPPING"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_APPLICANT_EMPLOYEE_MAPPING
WITH PARADOX_DATA AS(
	SELECT * FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.PARADOX_EMP_DEDUPE_OUTPUT
	WHERE SOURCE_SYSTEM_ID = 12 AND CLUSTER_ID IS NOT NULL
)
--SELECT * FROM PARADOX_DATA;
, DIM_EMPLOYEE_DATA AS (
	SELECT * FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.PARADOX_EMP_DEDUPE_OUTPUT
	WHERE SOURCE_SYSTEM_ID <> 12 AND CLUSTER_ID IS NOT NULL
)
--SELECT * FROM DIM_EMPLOYEE_DATA;
, PARADOX_RECORD AS (
	select * from (
    select row_number() over(partition by cluster_id order by HIRED_DATE DESC NULLS LAST) rn,*
    from PARADOX_DATA
  ) WHERE RN = 1
)
--SELECT * FROM PARADOX_RECORD ORDER BY CLUSTER_ID::INT;
, DIM_EMPLOYEE_NEW_RECORD AS (
	select * from (
    select row_number() over(partition by cluster_id order by EMPLOYEE_LAST_WORKED_DATE DESC NULLS LAST, EMPLOYEE_FIRST_CHECK_DATE DESC NULLS LAST, EMPLOYEE_LAST_WORKED_DATE DESC NULLS LAST, EMPLOYEE_HIRE_DATE DESC NULLS LAST) rn,*
    from DIM_EMPLOYEE_DATA
  ) WHERE RN = 1
)
, DIM_EMPLOYEE_OLD_ID AS (
	select * from (
    select row_number() over(partition by cluster_id order by EMPLOYEE_LAST_WORKED_DATE ASC NULLS LAST, EMPLOYEE_FIRST_CHECK_DATE ASC NULLS LAST, EMPLOYEE_LAST_WORKED_DATE ASC NULLS LAST, EMPLOYEE_HIRE_DATE ASC NULLS LAST) rn,*
    from DIM_EMPLOYEE_DATA
  ) WHERE RN = 1
)
--SELECT * FROM DIM_EMPLOYEE_OLD_ID ORDER BY CLUSTER_ID::INT;
, DIM_EMPLOYEE_RECORD as (
	SELECT DISTINCT O.EMPLOYEE_KEY, N.EMPLOYEE_ID, N.SYSTEM_CODE, N.EMPLOYEE_HIRE_DATE, N.SOURCE_SYSTEM_ID, N.ETL_INSERTED_DATE, N.CLUSTER_ID
	FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.PARADOX_EMP_DEDUPE_OUTPUT A 
	INNER JOIN DIM_EMPLOYEE_NEW_RECORD N ON A.EMPLOYEE_KEY = N.EMPLOYEE_KEY AND A.EMPLOYEE_ID = N.EMPLOYEE_ID
	INNER JOIN DIM_EMPLOYEE_OLD_ID O ON N.CLUSTER_ID = O.CLUSTER_ID
)
-- SELECT * FROM DIM_EMPLOYEE_RECORD ORDER BY CLUSTER_ID::INT;
SELECT
  A.EMPLOYEE_KEY AS APPLICANT_KEY,  
  DE.EMPLOYEE_KEY AS EMPLOYEE_KEY,
  A.EMPLOYEE_ID AS APPLICANT_ID,
  DE.EMPLOYEE_ID AS EMPLOYEE_ID,
  A.SOURCE_SYSTEM_ID AS APPLICANT_SOURCE_SYSTEM_ID,
  DE.SOURCE_SYSTEM_ID AS EMPLOYEE_SOURCE_SYSTEM_ID,
  A.SYSTEM_CODE AS APPLICANT_SYSTEM_CODE,
  DE.SYSTEM_CODE AS EMPLOYEE_SYSTEM_CODE,
  A.APPLIED_DATE AS APPLICANT_APPLIED_DATE,
  DE.EMPLOYEE_HIRE_DATE AS EMPLOYEE_HIRED_DATE,  
  A.ETL_INSERTED_DATE AS APPLICANT_ETL_INSERTED_DATE,
  DE.ETL_INSERTED_DATE AS EMPLOYEE_ETL_INSERTED_DATE
FROM PARADOX_RECORD A INNER JOIN DIM_EMPLOYEE_RECORD DE ON A.CLUSTER_ID = DE.CLUSTER_ID;
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}

