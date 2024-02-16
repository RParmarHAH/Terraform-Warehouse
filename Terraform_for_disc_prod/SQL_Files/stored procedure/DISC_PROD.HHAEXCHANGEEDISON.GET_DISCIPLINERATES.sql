CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEEDISON.GET_DISCIPLINERATES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEEDISON.GET_DisciplineRates 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEEDISON.DisciplineRates (SELECT t.$1 AS AgencyID, t.$2 AS DisciplineRateID, t.$3 AS DisciplineID, t.$4 AS DisciplineName, t.$5 AS PayRateID, t.$6 AS PayRateName, t.$7 AS FromDate, t.$8 AS ToDate, t.$9 AS Hourly, t.$10 AS Daily, t.$11 AS VisitRate, t.$12 AS Status, t.$13 AS PayrollSetupID, t.$14 AS PayrollSetupName, t.$15 AS CreatedBy, t.$16 AS CreatedDate, t.$17 AS UpdatedBy, t.$18 AS UpdatedDate, t.$19 AS SYS_CHANGE_VERSION, t.$20 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$20,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_dbo_DisciplineRates.*[.]csv.gz'')T);

    return ''Success'';
END;
';