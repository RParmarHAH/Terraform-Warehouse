resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_CAREGIVERSEARCHRESULT" {
	name ="GET_CAREGIVERSEARCHRESULT"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_CaregiverSearchResult 
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
    COPY INTO GENERATIONSALLIANCE.CaregiverSearchResult FROM (SELECT t.$1 AS CGSearchResultId, t.$2 AS ClientId, t.$3 AS ServiceCode, t.$4 AS ServiceRequestId, t.$5 AS ClassificationID, t.$6 AS className, t.$7 AS MessageID, t.$8 AS City, t.$9 AS CountyID, t.$10 AS DateFrom, t.$11 AS DateThru, t.$12 AS StartTime, t.$13 AS EndTime, t.$14 AS ClientNeeds, t.$15 AS Days, t.$16 AS Zip, t.$17 AS Gender, t.$18 AS AvailablePercentage, t.$19 AS MatchCGSkillsToClientNeeds, t.$20 AS IncludeApplicant, t.$21 AS ShowSchduleHour, t.$22 AS ReportName, t.$23 AS CreatedBy, t.$24 AS CreatedDate, t.$25 AS SelectedColumns, t.$26 AS IsMinTimeBetweenShiftsEnabled, t.$27 AS MinTimeBetweenShifts, t.$28 AS ShowOTAlert, t.$29 AS Proximity, t.$30 AS SYS_CHANGE_VERSION, t.$31 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$31,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_CaregiverSearchResult.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.CaregiverSearchResult AS WITH curr_v AS (SELECT CGSearchResultId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.CaregiverSearchResult GROUP BY CGSearchResultId) SELECT t.* FROM GENERATIONSALLIANCE.CaregiverSearchResult t INNER JOIN curr_v v ON t.CGSearchResultId = v.CGSearchResultId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

