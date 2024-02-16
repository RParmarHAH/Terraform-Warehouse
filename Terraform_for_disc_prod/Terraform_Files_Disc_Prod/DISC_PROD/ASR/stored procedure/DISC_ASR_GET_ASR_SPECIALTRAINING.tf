resource "snowflake_procedure" "DISC_ASR_GET_ASR_SPECIALTRAINING" {
	name ="GET_ASR_SPECIALTRAINING"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ASR.GET_ASR_SPECIALTRAINING 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_SPECIALTRAINING FROM (SELECT A.$1 AS SPECIALTRAININGID, A.$2 AS SPECIALTRAININGNAME, A.$3 AS SPECIALTRAININGDESCR, A.$4 AS ISSUEDATEAPPLIES, A.$5 AS EXPARATIONDATEAPPLIES, A.$6 AS NOTES, A.$7 AS NUMUNITSBEFOREALERT, A.$8 AS UNITSBEFOREALERTTYPE, A.$9 AS ISBCII, A.$10 AS ISFBI, A.$11 AS SPECIALTRAININGTYPE, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.Stage.AWSAZSTAGEPROD/ASR/Daily_Files/ASR_Data_Extract_SpecialTraining(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.ASR.ASR_SPECIALTRAINING AS WITH curr_v AS (SELECT SPECIALTRAININGID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_SPECIALTRAINING GROUP BY SPECIALTRAININGID) SELECT t.* FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_SPECIALTRAINING t INNER JOIN curr_v v ON t.SPECIALTRAININGID = v.SPECIALTRAININGID AND t.ETL_DELETED_FLAG = FALSE and t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

