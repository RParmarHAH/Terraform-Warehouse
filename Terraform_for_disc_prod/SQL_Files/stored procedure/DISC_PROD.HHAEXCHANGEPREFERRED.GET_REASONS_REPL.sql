CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEPREFERRED.GET_REASONS_REPL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEPREFERRED.GET_Reasons_REPL 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEPREFERRED.Reasons_REPL (SELECT t.$1 AS AgencyID, t.$2 AS ReasonId, t.$3 AS Reason, t.$4 AS ReasonDescription, t.$5 AS Active, t.$6 AS CreatedDate, t.$7 AS LastUpdatedDate, t.$8 AS CreatedBy, t.$9 AS LastUpdatedBy, t.$10 AS ReasonLocation, t.$11 AS SYS_CHANGE_VERSION, t.$12 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$12,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/PREFERRED/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEPREFERRED_dbo_Reasons_REPL.*[.]csv.gz'')T WHERE t.$1 IN (243, 371));

    return ''Success'';
END;
';