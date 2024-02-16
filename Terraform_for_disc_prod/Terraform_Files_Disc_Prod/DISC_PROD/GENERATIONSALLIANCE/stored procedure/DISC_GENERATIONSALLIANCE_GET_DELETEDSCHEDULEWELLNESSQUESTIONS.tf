resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_DELETEDSCHEDULEWELLNESSQUESTIONS" {
	name ="GET_DELETEDSCHEDULEWELLNESSQUESTIONS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_DeletedScheduleWellnessQuestions 
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
    COPY INTO GENERATIONSALLIANCE.DeletedScheduleWellnessQuestions FROM (SELECT t.$1 AS scheduleID, t.$2 AS QuestionID, t.$3 AS Answer, t.$4 AS createdBy, t.$5 AS created, t.$6 AS updatedBy, t.$7 AS lastUpdated, t.$8 AS IsAlerted, t.$9 AS DeletedBy, t.$10 AS DeletedDateTime, t.$11 AS SYS_CHANGE_VERSION, t.$12 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$12,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_DeletedScheduleWellnessQuestions.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.DeletedScheduleWellnessQuestions AS WITH curr_v AS (SELECT scheduleID, QuestionID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.DeletedScheduleWellnessQuestions GROUP BY scheduleID, QuestionID) SELECT t.* FROM GENERATIONSALLIANCE.DeletedScheduleWellnessQuestions t INNER JOIN curr_v v ON t.scheduleID = v.scheduleID AND t.QuestionID = v.QuestionID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

