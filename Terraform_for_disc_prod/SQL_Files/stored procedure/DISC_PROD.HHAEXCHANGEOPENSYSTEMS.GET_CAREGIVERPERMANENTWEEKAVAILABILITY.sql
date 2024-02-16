CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CAREGIVERPERMANENTWEEKAVAILABILITY("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CaregiverPermanentWeekAvailability 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CaregiverPermanentWeekAvailability (SELECT t.$1 AS AgencyID, t.$2 AS CaregiverPermanentWeekID, t.$3 AS CaregiverID, t.$4 AS OfficeID, t.$5 AS SaturdayAvailabilityType, t.$6 AS SaturdayLiveIn, t.$7 AS SaturdayFrom, t.$8 AS SaturdayTo, t.$9 AS SundayAvailabilityType, t.$10 AS SundayLiveIn, t.$11 AS SundayFrom, t.$12 AS SundayTo, t.$13 AS MondayAvailabilityType, t.$14 AS MondayLiveIn, t.$15 AS MondayFrom, t.$16 AS MondayTo, t.$17 AS TuesdayAvailabilityType, t.$18 AS TuesdayLiveIn, t.$19 AS TuesdayFrom, t.$20 AS TuesdayTo, t.$21 AS WednesdayAvailabilityType, t.$22 AS WednesdayFrom, t.$23 AS WednesdayTo, t.$24 AS WednesdayLiveIn, t.$25 AS ThursdayAvailabilityType, t.$26 AS ThursdayFrom, t.$27 AS ThursdayTo, t.$28 AS ThursdayLiveIn, t.$29 AS FridayAvailabilityType, t.$30 AS FridayLiveIn, t.$31 AS FridayFrom, t.$32 AS FridayTo, t.$33 AS ModifiedDate, t.$34 AS Deleted, t.$35 AS CreatedBy, t.$36 AS CreatedDate, t.$37 AS UpdatedBy, t.$38 AS SYS_CHANGE_VERSION, t.$39 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$39,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_CaregiverPermanentWeekAvailability.*[.]csv.gz'') T);

    return ''Success'';
END;
';