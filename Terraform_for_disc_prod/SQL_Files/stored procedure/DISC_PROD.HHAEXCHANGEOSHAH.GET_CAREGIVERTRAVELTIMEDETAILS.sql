CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_CAREGIVERTRAVELTIMEDETAILS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_CaregiverTravelTimeDetails 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.CaregiverTravelTimeDetails (SELECT t.$1 AS AgencyID, t.$2 AS TravelTimeDetailID, t.$3 AS CaregiverID, t.$4 AS CaregiverName, t.$5 AS CaregiverCode, t.$6 AS TravelDate, t.$7 AS TravelStartDateTime, t.$8 AS TravelEndDateTime, t.$9 AS TravelStartTime, t.$10 AS TravelEndTime, t.$11 AS TransportationMethod, t.$12 AS PayCode, t.$13 AS OverridePayRate, t.$14 AS PayRate, t.$15 AS OfficeID, t.$16 AS PayAmount, t.$17 AS Notes, t.$18 AS CreatedType, t.$19 AS PayrollBatchID, t.$20 AS PayrollBatchNumber, t.$21 AS TravelTimeBatchID, t.$22 AS TravelTimeBatchNumber, t.$23 AS CreatedDate, t.$24 AS ModifiedDate, t.$25 AS PayRateID, t.$26 AS SYS_CHANGE_VERSION, t.$27 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$27,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_CaregiverTravelTimeDetails.*[.]csv.gz'') T);

    return ''Success'';
END;
';