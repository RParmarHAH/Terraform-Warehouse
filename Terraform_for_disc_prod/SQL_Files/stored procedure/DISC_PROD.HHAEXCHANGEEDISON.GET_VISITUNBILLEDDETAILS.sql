CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEEDISON.GET_VISITUNBILLEDDETAILS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEEDISON.GET_VisitUnbilledDetails 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEEDISON.VisitUnbilledDetails (SELECT t.$1 AS AgencyID, t.$2 AS VisitUnbilledDetailID, t.$3 AS PatientID, t.$4 AS CaregiverID, t.$5 AS VisitDate, t.$6 AS PayerID, t.$7 AS TimesheetRequired, t.$8 AS TimesheetReceived, t.$9 AS IsSkilledVisit, t.$10 AS VisitRateID, t.$11 AS VisitRate, t.$12 AS SYS_CHANGE_VERSION, t.$13 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$13,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ ( PATTERN => ''.*edisonhomedb_dbo_VisitUnbilledDetails.*[.]csv.gz'', file_format => DISC_PROD.STAGE.MY_CSV_FORMAT)T);

    return ''Success'';
END;
';