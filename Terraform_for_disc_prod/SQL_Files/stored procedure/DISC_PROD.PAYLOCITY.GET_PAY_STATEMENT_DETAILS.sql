CREATE OR REPLACE PROCEDURE DISC_PROD.PAYLOCITY.GET_PAY_STATEMENT_DETAILS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.PAYLOCITY.GET_PAY_STATEMENT_DETAILS 
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
    COPY INTO DISC_PROD.PAYLOCITY.HIST_PAY_STATEMENT_DETAILS FROM (select j.$1:companyId as companyid, j.$1:employeeId::number as employeeid, j.$1:year as year, J.$1:api_response apiresponse, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, 0 as ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Paylocity/PAY_STATEMENT_DETAILS/COMPANY(file_format => DISC_PROD.STAGE.MY_JSON_FORMAT) j);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.PAYLOCITY.PAY_STATEMENT_DETAILS AS SELECT DISTINCT companyId companyId, employeeId employeeId, year year, value:amount::number(12,3) amount, value:checkDate::varchar checkDate, value:det::varchar det, value:detCode::varchar detCode, value:detType::varchar detType, value:eligibleCompensation::number eligibleCompensation, value:hours::number hours, value:rate::number rate, value:transactionNumber::number transactionNumber, value:transactionType::varchar transactionType, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, 0 as ETL_DELETED_FLAG FROM DISC_PROD.PAYLOCITY.HIST_PAY_STATEMENT_DETAILS, LATERAL FLATTEN( INPUT => apiresponse) WHERE ETL_LAST_UPDATED_DATE = (SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_PROD.PAYLOCITY.HIST_PAY_STATEMENT_DETAILS) UNION SELECT * FROM DISC_PROD.PAYLOCITY.PAY_STATEMENT_DETAILS_HISTORICAL;

    return ''Success'';
END;
';