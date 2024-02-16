resource "snowflake_procedure" "DISC_HHAEXCHANGEPREFERRED_GET_CAREGIVERSPECIALAVAILABILITY" {
	name ="GET_CAREGIVERSPECIALAVAILABILITY"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.GET_CaregiverSpecialAvailability 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.CaregiverSpecialAvailability (SELECT t.$1 AS AgencyID, t.$2 AS CaregiverSpecialAvailabilityID, t.$3 AS CaregiverID, t.$4 AS OfficeID, t.$5 AS FromDate, t.$6 AS ToDate, t.$7 AS SaturdayAvailabilityType, t.$8 AS SaturdayLiveIn, t.$9 AS SaturdayFrom, t.$10 AS SaturdayTo, t.$11 AS SundayAvailabilityType, t.$12 AS SundayLiveIn, t.$13 AS SundayFrom, t.$14 AS SundayTo, t.$15 AS MondayAvailabilityType, t.$16 AS MondayLiveIn, t.$17 AS MondayFrom, t.$18 AS MondayTo, t.$19 AS TuesdayAvailabilityType, t.$20 AS TuesdayLiveIn, t.$21 AS TuesdayFrom, t.$22 AS TuesdayTo, t.$23 AS WednesdayAvailabilityType, t.$24 AS WednesdayFrom, t.$25 AS WednesdayTo, t.$26 AS WednesdayLiveIn, t.$27 AS ThursdayAvailabilityType, t.$28 AS ThursdayFrom, t.$29 AS ThursdayTo, t.$30 AS ThursdayLiveIn, t.$31 AS FridayAvailabilityType, t.$32 AS FridayLiveIn, t.$33 AS FridayFrom, t.$34 AS FridayTo, t.$35 AS ModifiedDate, t.$36 AS Deleted, t.$37 AS CreatedBy, t.$38 AS CreatedDate, t.$39 AS UpdatedBy, t.$40 AS SYS_CHANGE_VERSION, t.$41 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$41,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/PREFERRED/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEPREFERRED_dbo_CaregiverSpecialAvailability.*[.]csv.gz'')T WHERE t.$1 IN (243, 371));

    return ''Success'';
END;

 EOT
}

