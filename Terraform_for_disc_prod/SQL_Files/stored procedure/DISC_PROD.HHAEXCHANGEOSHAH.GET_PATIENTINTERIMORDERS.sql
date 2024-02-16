CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_PATIENTINTERIMORDERS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_PatientInterimOrders 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.PatientInterimOrders (SELECT t.$1 AS AgencyID, t.$2 AS PatientID, t.$3 AS HeaderID, t.$4 AS DocID, t.$5 AS DetailID, t.$6 AS CreationDate, t.$7 AS CertificationStartDate, t.$8 AS CertificationEndDate, t.$9 AS Status, t.$10 AS StatusText, t.$11 AS CanDelete, t.$12 AS CategoryID, t.$13 AS Category, t.$14 AS IsAuto, t.$15 AS ScanFileName, t.$16 AS ScanFileGUID, t.$17 AS DataVersion, t.$18 AS CreatedDate, t.$19 AS FaxLogStatus, t.$20 AS FaxLogStatusText, t.$21 AS PhysicianFax, t.$22 AS PhysicianName, t.$23 AS DiagnosisCode, t.$24 AS DiagnosisDescription, t.$25 AS SYS_CHANGE_VERSION, t.$26 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$26,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_PatientInterimOrders.*[.]csv.gz'') T);

    return ''Success'';
END;
';