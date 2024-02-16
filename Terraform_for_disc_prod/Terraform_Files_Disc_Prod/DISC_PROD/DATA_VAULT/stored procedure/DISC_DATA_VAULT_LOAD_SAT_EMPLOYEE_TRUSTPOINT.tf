resource "snowflake_procedure" "DISC_DATA_VAULT_LOAD_SAT_EMPLOYEE_TRUSTPOINT" {
	name ="LOAD_SAT_EMPLOYEE_TRUSTPOINT"
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
					WITH base AS (SELECT EMPLOYEE_SSN, EMPLOYEE_NUMBER, ''8485'' DB
													 , RANK() OVER (PARTITION BY emp.EMPLOYEE_SSN
													   ORDER BY IFF(emp.EMPLOYEE_LAST_WORKED_DATE ::date = ''1900-01-01'', ''9999-12-31'', 
													   emp.EMPLOYEE_LAST_WORKED_DATE ::date) DESC,P.PAYROLL_DATE desc, 
													   emp.EMPLOYEE_HIRE_DATE DESC, ETL_LAST_UPDATED_DATE DESC, ETL_INSERTED_DATE DESC) as rnk_SSN
													 , RANK() OVER (PARTITION BY emp.EMPLOYEE_NUMBER
													   ORDER BY IFF(emp.EMPLOYEE_LAST_WORKED_DATE::date = ''1900-01-01'', ''9999-12-31'', 
													   emp.EMPLOYEE_LAST_WORKED_DATE::date) DESC,P.PAYROLL_DATE desc, 
													   emp.EMPLOYEE_HIRE_DATE DESC, ETL_LAST_UPDATED_DATE DESC, ETL_INSERTED_DATE DESC) as rnk_pay
					FROM DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEES emp left join 
														(SELECT TRY_CAST(EMPLOYEE_ID as BIGINT) EMPLOYEE_ID,max(PAYROLL_DATE) PAYROLL_DATE
														 FROM DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.PAYROLL
														 GROUP BY 1
														) P on emp.EMPLOYEE_NUMBER=P.EMPLOYEE_ID
WHERE emp.ETL_LAST_UPDATED_DATE >= ''1900-01-01''  and (EMPLOYEE_ssn not like ''000000%'') and (EMPLOYEE_ssn is not NULL) and (EMPLOYEE_ssn<>'''')
) 
					SELECT
						 MD5(em.EMPLOYEE_SSN) AS HASH_EMPLOYEE_KEY
						, em.EMPLOYEE_SSN AS EMPLOYEE_SID
						, EMPLOYEE_FIRST_NAME
						, EMPLOYEE_LAST_NAME
						, em.EMPLOYEE_NUMBER as EMPLOYEE_ID
						, ''8485'' RECORD_SYSTEM_CODE
						, 6 AS RECORD_SOURCE_SYSTEM_ID
						, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
                        , :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
						, convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
						, CURRENT_USER as ETL_INSERTED_BY
						, convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE
						, CURRENT_USER as ETL_LAST_UPDATED_BY
						, 0 as ETL_DELETED_FLAG
					FROM DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEES em
					JOIN base b ON em.EMPLOYEE_number = b.EMPLOYEE_number AND b.rnk_ssn = 1 AND b.rnk_pay = 1;

	               CREATE OR REPLACE TABLE DATA_VAULT.SAT_EMPLOYEE_TRUSTPOINT AS 
					SELECT
						MD5(tp.EMPLOYEE_SSN) AS HASH_EMPLOYEE_KEY
						, tp.*,P.PAYROLL_DATE
					FROM DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEES tp 
					 left join 
					 (SELECT TRY_CAST(EMPLOYEE_ID as BIGINT) EMPLOYEE_ID,max(PAYROLL_DATE) PAYROLL_DATE
						FROM DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.PAYROLL
						GROUP BY 1
						) P on tp.EMPLOYEE_NUMBER=P.EMPLOYEE_ID
					where (tp.EMPLOYEE_ssn not like ''000000%'') and (tp.EMPLOYEE_ssn is not NULL) and (tp.EMPLOYEE_ssn<>'''');

	            CREATE OR REPLACE TABLE DATA_VAULT.VW_SAT_EMPLOYEE_TRUSTPOINT AS
					WITH latest as (SELECT HASH_EMPLOYEE_KEY, ''8485'' DB,MAX(ETL_LAST_UPDATED_DATE) max_date
						FROM DISC_${var.SF_ENVIRONMENT}.DATA_VAULT.SAT_EMPLOYEE_TRUSTPOINT GROUP BY 1,2)
					SELECT sat.*
					FROM DISC_${var.SF_ENVIRONMENT}.DATA_VAULT.SAT_EMPLOYEE_TRUSTPOINT sat
					JOIN latest vw ON sat.HASH_EMPLOYEE_KEY = vw.HASH_EMPLOYEE_KEY
						AND sat.ETL_LAST_UPDATED_DATE =  vw.max_date;
	
	               INSERT INTO DATA_VAULT.LINK_EMPLOYEE
					WITH new_rec AS ( select 
							TP.LINK_EMPLOYEE_KEY
							,S.HASH_EMPLOYEE_KEY
							,TP.EMPLOYEE_NUMBER
							,TP.DB
							,TP.SOURCE_SYSTEM_ID 
							 , :STR_ETL_TASK_KEY AS ETL_TASK_KEY
                             , :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
							 , TP.ETL_INSERTED_DATE
							 , TP.ETL_INSERTED_BY
							 , 0 AS ETL_DELETED_FLAG
							 from 
							(SELECT distinct 
							CASE 
							WHEN (
								   (T.EMPLOYEE_SSN=stf.ssn 
								   OR 
								   T.EMPLOYEE_NUMBER = TRY_CAST(stf.STAFFAGENCYID AS INTEGER)) and stf.AGENCYID = ''8485'' AND stf.Person = ''TRUE''
								  )
								   THEN MD5(NVL(stf.AGENCYID,''S'') || ''-'' || TRY_CAST(NVL(stf.STAFFAGENCYID,'''') AS Integer) || ''-'' || ''1900-01-01'' || ''-'' || ''SANDATAIMPORT'')
							ELSE 
							MD5(NVL(stf.AGENCYID,''S'') || ''-'' || UPPER(NVL(TRIM(T.Employee_Number),'''')) || ''-'' || ''1900-01-01'' || ''-'' || ''TrustPointData'') 
							END AS LINK_EMPLOYEE_KEY,
							 T.EMPLOYEE_SSN
							 , T.EMPLOYEE_NUMBER
							 , ''8485'' DB
							 , ''6'' AS SOURCE_SYSTEM_ID
                             , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_INSERTED_DATE
							 , CURRENT_USER AS ETL_INSERTED_BY

						FROM DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEES T LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.SandataImport.Sandata_Staffs AS stf 
						ON stf.AGENCYID = ''8485'' AND stf.Person = ''TRUE'' AND T.EMPLOYEE_NUMBER = TRY_CAST(stf.STAFFAGENCYID AS INTEGER)
						) TP
                        INNER JOIN DATA_VAULT.VW_SAT_EMPLOYEE_TRUSTPOINT S ON S.HASH_EMPLOYEE_KEY = MD5(TP.EMPLOYEE_SSN)
					)
					SELECT ct.*
					FROM new_rec ct;
SELECT CONCAT('' '',"number of rows inserted",'' Rows Inserted.'') into :return_result_temp FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return CONCAT(return_result,'' | '',return_result_temp);
END;

 EOT
}

