resource "snowflake_procedure" "DISC_PAYLOCITY_GET_EMPLOYEE_LIST" {
	name ="GET_EMPLOYEE_LIST"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PAYLOCITY"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.PAYLOCITY.GET_EMPLOYEE_LIST 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    COPY INTO DISC_${var.SF_ENVIRONMENT}.PAYLOCITY.HIST_EMPLOYEE_LIST FROM (select j.$1:companyId as CompanyID, J.$1:api_response as ApiResponse, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, 0 as ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Paylocity/ALL_EMPLOYEE/ALL_EMPLOYEES(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_JSON_FORMAT) j);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.PAYLOCITY.EMPLOYEE_LIST AS SELECT distinct companyId::varchar as CompanyID, value:employeeId::number employeeId,value:statusCode::varchar statusCode,value:statusTypeCode::varchar statusTypeCode, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, 0 as ETL_DELETED_FLAG FROM DISC_${var.SF_ENVIRONMENT}.PAYLOCITY.HIST_EMPLOYEE_LIST, LATERAL FLATTEN( INPUT => apiresponse) WHERE ETL_LAST_UPDATED_DATE = (SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_${var.SF_ENVIRONMENT}.PAYLOCITY.HIST_EMPLOYEE_LIST);

    return ''Success'';
END;

 EOT
}

