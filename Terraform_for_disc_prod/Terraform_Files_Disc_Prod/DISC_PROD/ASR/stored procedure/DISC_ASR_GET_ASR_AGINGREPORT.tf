resource "snowflake_procedure" "DISC_ASR_GET_ASR_AGINGREPORT" {
	name ="GET_ASR_AGINGREPORT"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ASR.GET_ASR_AGINGREPORT 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_AGINGREPORT FROM (SELECT A.$1 AS INVOICE_NO, A.$2 AS INVOICE_DATE, A.$3 AS SEGMENT, A.$4 AS SERVICE_TYPE, A.$5 AS CLIENT_NAME, A.$6 AS DATE_OF_SERVICE, A.$8 AS INVOICE_AMOUNT, A.$9 AS RECEIVED_AMOUNT, A.$10 AS ADJUSTMENT_POSITIVE, A.$11 AS ADJUSTMENT_NEGATIVE, A.$12 AS BALANCE, A.$13 AS "CURRENT", A.$14 AS "31-60", A.$15 AS "61-90", A.$16 AS "91-120", A.$17 AS "120+", A.$18 AS STATUS, A.$19 AS CLAIM_NUMBER, A.$20 AS CUSTOMERID, A.$21 AS EMPLOYEEID, A.$22 AS LOCATIONID, A.$23 AS PAYERSOURCEID, A.$24 AS PAIDDATE, A.$25 AS BILLINGCODEID, A.$26 AS DEPOSITDATE, A.$27 AS SERVICEVISITID, A.$28 AS SERVICEVISITACTUALID, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.Stage.AWSAZSTAGEPROD/ASR/Daily_Files/ASR_Data_Extract_AgingReport(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.ASR.ASR_AGINGREPORT AS WITH curr_v AS (SELECT INVOICE_NO, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_AGINGREPORT GROUP BY INVOICE_NO) SELECT t.* FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_AGINGREPORT T INNER JOIN curr_v v ON t.INVOICE_NO = v.INVOICE_NO AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

