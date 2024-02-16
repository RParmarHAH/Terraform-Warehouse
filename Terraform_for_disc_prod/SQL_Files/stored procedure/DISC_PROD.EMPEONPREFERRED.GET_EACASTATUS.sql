CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONPREFERRED.GET_EACASTATUS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonPreferred.GET_EACAStatus 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonPreferred.EACAStatus (SELECT t.$1 AS statusCodeId, t.$2 AS co, t.$3 AS id, t.$4 AS statusCode, t.$5 AS startDate, t.$6 AS endDate, t.$7 AS lastChange, t.$8 AS lastChangeUser, t.$9 AS SYS_CHANGE_VERSION, t.$10 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$10,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonPreferred_dbo_EACAStatus.*[.]csv.gz'')T);

    
    return ''Success'';
END;
';