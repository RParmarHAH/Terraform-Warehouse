resource "snowflake_procedure" "DISC_ASR_GET_ASR_CUSTOMER_DETAILS" {
	name ="GET_ASR_CUSTOMER_DETAILS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ASR.GET_ASR_CUSTOMER_DETAILS 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_CUSTOMER_DETAILS FROM (SELECT A.$1 AS CUSTOMERID, A.$2 AS CUSTOMER_EXTENDED_PROPERTY, A.$3 AS PROPERTY_VALUE, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.Stage.AWSAZSTAGEPROD/ASR/Daily_Files/ASR_Data_Extract_CustomerDetails(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT_ENCLOSED_BY_NONE) A);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.ASR.ASR_CUSTOMER_DETAILS AS WITH curr_v AS (SELECT CUSTOMERID, CUSTOMER_EXTENDED_PROPERTY, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_CUSTOMER_DETAILS WHERE CUSTOMER_EXTENDED_PROPERTY IS NOT NULL GROUP BY CUSTOMERID, CUSTOMER_EXTENDED_PROPERTY) SELECT t.* FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_CUSTOMER_DETAILS t INNER JOIN curr_v v ON t.CUSTOMERID = v.CUSTOMERID AND t.CUSTOMER_EXTENDED_PROPERTY = v.CUSTOMER_EXTENDED_PROPERTY AND t.ETL_DELETED_FLAG = FALSE and t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

