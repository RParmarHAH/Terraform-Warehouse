resource "snowflake_procedure" "DISC_DATA_VAULT_LOAD_SAT_EMPLOYEE_GP" {
	name ="LOAD_SAT_EMPLOYEE_GP"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_VAULT"
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
  return_result_temp varchar(1000);
BEGIN
	        INSERT OVERWRITE INTO DATA_VAULT.HUB_EMPLOYEE
					WITH base AS (SELECT ssn, EMPLOYEE_ID, db
							, RANK() OVER (PARTITION BY emp.ssn
								 ORDER BY IFF(emp.LAST_DAY_WORKED::date = ''1900-01-01'', ''9999-12-31'', emp.LAST_DAY_WORKED::date) DESC
									 , emp.LAST_CHECK_DATE DESC, emp.HIRE_DATE DESC, emp.FIRST_CHECK_DATE DESC, ETL_LAST_UPDATED_DATE DESC, ETL_INSERTED_DATE DESC) as rnk_ssn
							, RANK() OVER (PARTITION BY emp.EMPLOYEE_ID
								 ORDER BY IFF(emp.LAST_DAY_WORKED::date = ''1900-01-01'', ''9999-12-31'', emp.LAST_DAY_WORKED::date) DESC
									 , emp.LAST_CHECK_DATE DESC, emp.HIRE_DATE DESC, emp.FIRST_CHECK_DATE DESC, ETL_LAST_UPDATED_DATE DESC, ETL_INSERTED_DATE DESC) as rnk_pay
						FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.GPALLEMPLOYEESBASE emp
						WHERE emp.ETL_LAST_UPDATED_DATE >= ''1900-01-01'') --need to pull all records to check by partition
					SELECT
						 MD5(em.ssn) AS HASH_EMPLOYEE_KEY
						, em.ssn AS EMPLOYEE_SID
						, first_name AS EMPLOYEE_FIRST_NAME
						, last_name AS EMPLOYEE_LAST_NAME
						, em.EMPLOYEE_ID as EMPLOYEE_ID
						, em.DB AS RECORD_SYSTEM_CODE
						, 5 AS RECORD_SOURCE_SYSTEM_ID
						, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
                        , :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
						, convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
						, CURRENT_USER as ETL_INSERTED_BY
						, convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE
						, CURRENT_USER as ETL_LAST_UPDATED_BY
						, 0 as ETL_DELETED_FLAG
					FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.GPALLEMPLOYEESBASE em
					JOIN base b ON em.EMPLOYEE_ID = b.EMPLOYEE_ID AND em.db = b.db AND b.rnk_ssn = 1 AND b.rnk_pay = 1
					WHERE em.EMPLOYEE_ID not in (''213000069814'',''214000084795'');
	SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));				
	
	            CREATE OR REPLACE TABLE DATA_VAULT.SAT_EMPLOYEE_GP AS 
					SELECT
						MD5(gp.ssn) AS HASH_EMPLOYEE_KEY
						, *
					FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.GPALLEMPLOYEESBASE gp;

	
	            CREATE OR REPLACE TABLE DATA_VAULT.VW_SAT_EMPLOYEE_GP AS
					WITH latest as (SELECT HASH_EMPLOYEE_KEY, DB,MAX(ETL_LAST_UPDATED_DATE) max_date
						FROM DATA_VAULT.SAT_EMPLOYEE_GP GROUP BY 1,2)
					SELECT sat.*
					FROM DATA_VAULT.SAT_EMPLOYEE_GP sat
					JOIN latest vw ON sat.HASH_EMPLOYEE_KEY = vw.HASH_EMPLOYEE_KEY
						AND sat.ETL_LAST_UPDATED_DATE =  vw.max_date
						and sat.DB = vw.DB;

	
	            INSERT OVERWRITE INTO DATA_VAULT.LINK_EMPLOYEE
					WITH new_rec AS (
						SELECT distinct MD5(CAST( GP.EMPLOYEE_ID AS VARCHAR) || ''-'' || GP.DB) AS LINK_EMPLOYEE_KEY
							 , s.HASH_EMPLOYEE_KEY
							 , GP.EMPLOYEE_ID
							 , GP.db
							 , ''5'' AS SOURCE_SYSTEM_ID
							 ,  :STR_ETL_TASK_KEY AS ETL_TASK_KEY
                             ,  :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
							 , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_INSERTED_DATE
							 , CURRENT_USER AS ETL_INSERTED_BY
							 , 0 AS ETL_DELETED_FLAG
						FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.GPALLEMPLOYEESBASE GP
                        INNER JOIN DATA_VAULT.VW_SAT_EMPLOYEE_GP s ON S.HASH_EMPLOYEE_KEY = MD5(gp.ssn)
						and s.db = gp.db

					)
					SELECT ct.*
					FROM new_rec ct;
	
SELECT CONCAT('' '',"number of rows inserted",'' Rows Inserted.'') into :return_result_temp FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return CONCAT(return_result,'' | '',return_result_temp);
END;

 EOT
}

