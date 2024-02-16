resource "snowflake_procedure" "DISC_PAYLOCITY_GET_PAY_STATEMENT_SUMMARY" {
	name ="GET_PAY_STATEMENT_SUMMARY"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.PAYLOCITY.GET_PAY_STATEMENT_SUMMARY 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.PAYLOCITY.HIST_PAY_STATEMENT_SUMMARY FROM (select j.$1:companyId as companyid, j.$1:employeeId::number as employeeid, j.$1:year as year, J.$1:api_response apiresponse, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, 0 as ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Paylocity/PAY_STATEMENT_SUMMARY/COMPANY(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_JSON_FORMAT) j);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.PAYLOCITY.PAY_STATEMENT_SUMMARY AS SELECT distinct companyId companyId, employeeId employeeId, year year, value:autoPay::boolean autoPay, value:beginDate::varchar beginDate, value:checkDate::varchar checkDate, value:checkNumber::number checkNumber, value:directDepositAmount::number directDepositAmount, value:endDate::varchar endDate, value:grossPay::number grossPay, value:hours::number hours, value:netCheck::number netCheck, value:netPay::number netPay, value:overtimeDollars::number overtimeDollars, value:overtimeHours::number overtimeHours, value:process::number process, value:regularDollars::number regularDollars, value:regularHours::number regularHours, value:transactionNumber::number transactionNumber, value:voucherNumber::number voucherNumber, value:workersCompCode::varchar workersCompCode, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, 0 as ETL_DELETED_FLAG FROM DISC_${var.SF_ENVIRONMENT}.PAYLOCITY.HIST_PAY_STATEMENT_SUMMARY, LATERAL FLATTEN( INPUT => apiresponse) WHERE ETL_LAST_UPDATED_DATE = (SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_${var.SF_ENVIRONMENT}.PAYLOCITY.HIST_PAY_STATEMENT_SUMMARY) UNION SELECT * FROM DISC_${var.SF_ENVIRONMENT}.PAYLOCITY.PAY_STATEMENT_SUMMARY_HISTORICAL;

    return ''Success'';
END;

 EOT
}

