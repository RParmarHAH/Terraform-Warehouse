resource "snowflake_procedure" "DISC_VIVENTIUM_GET_PAY_CODES" {
	name ="GET_PAY_CODES"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "VIVENTIUM"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN 
    --TargetSQL
    insert into disc_prod.viventium.hist_pay_codes SELECT  j.$1:divisionKey:companyCode AS companycode, j.$1:divisionKey:divisionCode AS divisioncode , j.$1:taxCode as pay_code , j.$1:taxDescription as pay_code_description, ''T'' as pay_code_type, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE, CURRENT_USER AS ETL_INSERTED_BY , CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE, CURRENT_USER AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG, 0 AS ETL_INFERRED_MEMBER_FLAG from  @disc_prod.STAGE.AWSAZSTAGEPROD/Viventium/Daily_Files/ExportTaxes/(file_format => disc_prod.PUBLIC.MY_JSON_FORMAT) j UNION ALL SELECT  j.$1:divisionKey:companyCode AS companycode, j.$1:divisionKey:divisionCode AS divisioncode , j.$1:earningCode as pay_code , j.$1:earningDescription as pay_code_description, ''E'' as pay_code_type, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE, CURRENT_USER AS ETL_INSERTED_BY , CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE, CURRENT_USER AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG, 0 AS ETL_INFERRED_MEMBER_FLAG from  @disc_prod.STAGE.AWSAZSTAGEPROD/Viventium/Daily_Files/ExportEarnings/(file_format => disc_prod.PUBLIC.MY_JSON_FORMAT) j UNION ALL SELECT  j.$1:divisionKey:companyCode AS companycode, j.$1:divisionKey:divisionCode AS divisioncode , j.$1:deductionCode as pay_code , j.$1:deductionDescription as pay_code_description, ''D'' as pay_code_type, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE, CURRENT_USER AS ETL_INSERTED_BY , CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE, CURRENT_USER AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG, 0 AS ETL_INFERRED_MEMBER_FLAG from  @disc_prod.STAGE.AWSAZSTAGEPROD/Viventium/Daily_Files/ExportDeductions/(file_format => disc_prod.PUBLIC.MY_JSON_FORMAT) j;

    --ViewSQL
    CREATE OR REPLACE TABLE disc_prod.VIVENTIUM.pay_codes AS WITH curr_v AS ( SELECT PAY_CODE  ,PAY_CODE_DESCRIPTION  , max(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM disc_prod.VIVENTIUM.HIST_pay_codes GROUP BY PAY_CODE  ,PAY_CODE_DESCRIPTION) SELECT HP.* EXCLUDE ETL_DELETED_FLAG,CASE WHEN ETL_INSERTED_DATE::DATE <> CURRENT_DATE THEN TRUE ELSE HP.ETL_DELETED_FLAG END AS ETL_DELETED_FLAG   FROM disc_prod.VIVENTIUM.HIST_pay_codes HP  INNER JOIN curr_v v ON HP.PAY_CODE = v.PAY_CODE AND HP.PAY_CODE_DESCRIPTION = v.PAY_CODE_DESCRIPTION   AND HP.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

