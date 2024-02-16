resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_SAVEDSHIFTSEARCHRESULT" {
	name ="GET_SAVEDSHIFTSEARCHRESULT"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_SavedShiftSearchResult 
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
    COPY INTO GENERATIONSALLIANCE.SavedShiftSearchResult FROM (SELECT t.$1 AS UserID, t.$2 AS SocialSecurityNum, t.$3 AS Applicant, t.$4 AS FirstName, t.$5 AS LastName, t.$6 AS Class, t.$7 AS City, t.$8 AS Zip, t.$9 AS County, t.$10 AS Phone1, t.$11 AS Phone2, t.$12 AS Distance, t.$13 AS Pref, t.$14 AS PriorVisit, t.$15 AS State, t.$16 AS Address1, t.$17 AS Address2, t.$18 AS TextMessage, t.$19 AS Str_Gender, t.$20 AS TotalHours, t.$21 AS EmployeeName, t.$22 AS AvailabilityPercent, t.$23 AS OTAlert, t.$24 AS Latitude, t.$25 AS Longitude, t.$26 AS strDistance, t.$27 AS TotalCount, t.$28 AS SYS_CHANGE_VERSION, t.$29 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$29,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_SavedShiftSearchResult.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.SavedShiftSearchResult AS WITH curr_v AS (SELECT UserID, SocialSecurityNum, Applicant, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.SavedShiftSearchResult GROUP BY UserID, SocialSecurityNum, Applicant) SELECT t.* FROM GENERATIONSALLIANCE.SavedShiftSearchResult t INNER JOIN curr_v v ON t.UserID = v.UserID AND t.SocialSecurityNum = v.SocialSecurityNum AND t.Applicant = v.Applicant AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

