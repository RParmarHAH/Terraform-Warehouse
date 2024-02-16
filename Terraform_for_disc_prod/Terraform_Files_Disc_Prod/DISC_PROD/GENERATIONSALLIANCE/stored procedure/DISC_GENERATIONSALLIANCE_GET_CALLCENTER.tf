resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_CALLCENTER" {
	name ="GET_CALLCENTER"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_callcenter 
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
    COPY INTO GENERATIONSALLIANCE.callcenter FROM (SELECT t.$1 AS callId, t.$2 AS caller, t.$3 AS EnteredDateTime, t.$4 AS PersonTakingCall, t.$5 AS CallDescription, t.$6 AS IsResolved, t.$7 AS ResolvedDateTime, t.$8 AS noteTypeID, t.$9 AS createdBy, t.$10 AS created, t.$11 AS updatedBy, t.$12 AS lastUpdated, t.$13 AS xferToNotes, t.$14 AS LocationID, t.$15 AS callerType, t.$16 AS int_ReferralID, t.$17 AS dtmDateDue, t.$18 AS strAssignedTo, t.$19 AS callerID, t.$20 AS xferTooutlook, t.$21 AS SecondaryCaller, t.$22 AS SecondaryReferrer, t.$23 AS className, t.$24 AS NotifiedUsers, t.$25 AS NotePriority, t.$26 AS IsDeletedAttachedNote, t.$27 AS ParentCallID, t.$28 AS SYS_CHANGE_VERSION, t.$29 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$29,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_callcenter.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.callcenter AS WITH curr_v AS (SELECT callId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.callcenter GROUP BY callId) SELECT t.* FROM GENERATIONSALLIANCE.callcenter t INNER JOIN curr_v v ON t.callId = v.callId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

