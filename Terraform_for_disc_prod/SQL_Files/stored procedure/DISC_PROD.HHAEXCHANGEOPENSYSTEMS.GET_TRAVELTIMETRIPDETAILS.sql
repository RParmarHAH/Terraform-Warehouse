CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_TRAVELTIMETRIPDETAILS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_TravelTimeTripDetails 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.TravelTimeTripDetails (SELECT t.$1 AS AgencyID, t.$2 AS TravelTimeTripDetailID, t.$3 AS TravelTimeDetailID, t.$4 AS TravelTimeCalculatedDetailID, t.$5 AS TravelTimeBatchID, t.$6 AS TravelDate, t.$7 AS GapTime, t.$8 AS CaregiverCode, t.$9 AS CaregiverName, t.$10 AS CaregiverID, t.$11 AS OfficeID, t.$12 AS VisitID1, t.$13 AS VisitID2, t.$14 AS VisitHours1, t.$15 AS VisitHours2, t.$16 AS VisitScheduledHours1, t.$17 AS VisitScheduledHours2, t.$18 AS PatientID1, t.$19 AS PatientID2, t.$20 AS PatientName1, t.$21 AS PatientName2, t.$22 AS TravelTimeValue, t.$23 AS TransportationMethod, t.$24 AS SYS_CHANGE_VERSION, t.$25 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$25,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_TravelTimeTripDetails.*[.]csv.gz'') T);

    return ''Success'';
END;
';