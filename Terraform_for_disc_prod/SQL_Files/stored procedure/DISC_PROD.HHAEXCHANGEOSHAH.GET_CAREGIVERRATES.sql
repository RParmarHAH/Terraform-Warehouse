CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_CAREGIVERRATES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_CaregiverRates 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.CaregiverRates (SELECT t.$1 AS AgencyID, t.$2 AS CaregiverRateID, t.$3 AS CaregiverID, t.$4 AS FromDate, t.$5 AS ToDate, t.$6 AS Hourly, t.$7 AS Daily, t.$8 AS Visit, t.$9 AS PatientID, t.$10 AS AdmissionID, t.$11 AS PatientName, t.$12 AS DisciplineID, t.$13 AS Discipline, t.$14 AS PayrateID, t.$15 AS PayRateText, t.$16 AS CreatedDate, t.$17 AS Status, t.$18 AS SYS_CHANGE_VERSION, t.$19 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$19,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_CaregiverRates.*[.]csv.gz'') T);

    return ''Success'';
END;
';