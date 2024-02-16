resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_SCHEDULESIGNATURE" {
	name ="GET_SCHEDULESIGNATURE"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_ScheduleSignature 
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
    COPY INTO GENERATIONSALLIANCE.ScheduleSignature FROM (SELECT t.$1 AS ScheduleSignatureID, t.$2 AS ScheduleID, t.$3 AS Created, t.$4 AS CreatedBy, t.$5 AS Updated, t.$6 AS UpdatedBy, t.$7 AS ChartingID, t.$8 AS ChartingType, t.$9 AS ClientSign, t.$10 AS CaregiverSign, t.$11 AS ClientSignDate, t.$12 AS CaregiverSignDate, t.$13 AS CaregiverVoiceURL, t.$14 AS ClientVoiceURL, t.$15 AS SignedScheduleStart, t.$16 AS SignedScheduleEnd, t.$17 AS CaregiverSignatureMode, t.$18 AS ClientSignatureMode, t.$19 AS ServiceApproval, t.$20 AS TimeTaskAppproval, t.$21 AS SignatureMethod, t.$22 AS SYS_CHANGE_VERSION, t.$23 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$23,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_ScheduleSignature.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.ScheduleSignature AS WITH curr_v AS (SELECT ScheduleSignatureID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.ScheduleSignature GROUP BY ScheduleSignatureID) SELECT t.* FROM GENERATIONSALLIANCE.ScheduleSignature t INNER JOIN curr_v v ON t.ScheduleSignatureID = v.ScheduleSignatureID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

