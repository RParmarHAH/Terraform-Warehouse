resource "snowflake_procedure" "DISC_DATA_VAULT_LOAD_SAT_EMPLOYEE_DATAFLEX" {
	name ="LOAD_SAT_EMPLOYEE_DATAFLEX"
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
	        INSERT INTO DATA_VAULT.HUB_EMPLOYEE
					WITH base AS (SELECT ssn, dbname,number as employee_id, ROW_NUMBER() OVER (PARTITION BY ssn ORDER BY NUMBER DESC,
					UPDATEDTIME DESC,LASTCHECKDATE DESC, DATEADDED DESC) AS rnk_ssn
						FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFEMPLOYEES b
						WHERE b.ETL_LAST_UPDATED_DATE >= ''1900-01-01'' --need to pull all records to check by partition
						)
					SELECT
						 MD5(em.ssn) AS HASH_EMPLOYEE_KEY
						, em.ssn AS EMPLOYEE_SID
						, FIRSTNAME AS EMPLOYEE_FIRST_NAME
						, LASTNAME AS EMPLOYEE_LAST_NAME
						, em.NUMBER as EMPLOYEE_ID
						, EM.DBNAME AS RECORD_SYSTEM_CODE
						, 3 AS RECORD_SOURCE_SYSTEM_ID
						, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
                        , :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
						, convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
						, CURRENT_USER as ETL_INSERTED_BY
						, convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE
						, CURRENT_USER as ETL_LAST_UPDATED_BY
						, 0 as ETL_DELETED_FLAG
					FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFEMPLOYEES em
					JOIN base b ON em.NUMBER = b.EMPLOYEE_ID AND em.SSN = b.ssn and em.dbname = b.dbname and rnk_ssn =1
--					AND MD5(em.ssn) NOT IN (SELECT HASH_EMPLOYEE_KEY FROM DATA_VAULT.HUB_EMPLOYEE)
                    AND em.ssn IN 
					(
					select d.ssn from DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFEMPLOYEES d
					except
					select g.ssn from DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.GPALLEMPLOYEESBASE g
					)
					and em.payrollid not in (select EMPLOYEE_ID from DATA_VAULT.LINK_EMPLOYEE 
					where source_system_id = 5)
					and em.dbname <> ''PA'' and em.payrollid NOT LIKE ''%-%'';
		SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));			
	
	      CREATE OR REPLACE TABLE DATA_VAULT.SAT_EMPLOYEE_DATAFLEX AS 
					SELECT
						COALESCE(gp.HASH_EMPLOYEE_KEY, MD5(df.SSN)) AS HASH_EMPLOYEE_KEY
						, df.*
					FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFEMPLOYEES df
					LEFT JOIN (SELECT distinct employee_id,HASH_EMPLOYEE_KEY 
                               FROM DATA_VAULT.LINK_EMPLOYEE
                               where SOURCE_SYSTEM_ID = ''5'') gp ON df.PAYROLLID = gp.EMPLOYEE_ID;
	
	        CREATE OR REPLACE TABLE DATA_VAULT.VW_SAT_EMPLOYEE_DATAFLEX AS
					WITH latest as (SELECT HASH_EMPLOYEE_KEY,dbname, MAX(ETL_LAST_UPDATED_DATE) max_date
						FROM DATA_VAULT.SAT_EMPLOYEE_DATAFLEX GROUP BY 1,2)
					SELECT sat.*
					FROM DATA_VAULT.SAT_EMPLOYEE_DATAFLEX sat
					JOIN latest vw ON sat.HASH_EMPLOYEE_KEY = vw.HASH_EMPLOYEE_KEY
						AND sat.ETL_LAST_UPDATED_DATE =  vw.max_date
						and vw.dbname = sat.dbname;
	
                  INSERT INTO DATA_VAULT.LINK_EMPLOYEE
					WITH new_rec AS (
						SELECT distinct md5(COALESCE(df.DBNAME,'''') || ''-'' || UPPER(NVL(TRIM(df.NUMBER), '''')) || ''-''  ||  ''1900-01-01'' || ''-'' || ''DATAFLEXSYNCDATA'') AS LINK_EMPLOYEE_KEY
							 , nvl(gp.HASH_EMPLOYEE_KEY,vsdf.HASH_EMPLOYEE_KEY)
							 , df.NUMBER::string
							 , df.DBNAME
							 , ''3'' AS SOURCE_SYSTEM_ID
							 , :STR_ETL_TASK_KEY AS ETL_TASK_KEY
                             , :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
							 , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_INSERTED_DATE
							 , CURRENT_USER AS ETL_INSERTED_BY
							 , 0 AS ETL_DELETED_FLAG
						FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFEMPLOYEES DF
                        LEFT JOIN DATA_VAULT.LINK_EMPLOYEE gp ON df.PAYROLLID = gp.EMPLOYEE_ID
						AND gp.SOURCE_SYSTEM_ID = ''5''
						LEFT JOIN DATA_VAULT.VW_SAT_EMPLOYEE_DATAFLEX vsdf ON vsdf.HASH_EMPLOYEE_KEY =  MD5(df.SSN)
						and df.DBNAME = vsdf.dbname
					)
					SELECT ct.*
					FROM new_rec ct
					WHERE ct.LINK_EMPLOYEE_KEY
						NOT IN (SELECT LINK_EMPLOYEE_KEY FROM DATA_VAULT.LINK_EMPLOYEE);
SELECT CONCAT('' '',"number of rows inserted",'' Rows Inserted.'') into :return_result_temp FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return CONCAT(return_result,'' | '',return_result_temp);
END;

 EOT
}

