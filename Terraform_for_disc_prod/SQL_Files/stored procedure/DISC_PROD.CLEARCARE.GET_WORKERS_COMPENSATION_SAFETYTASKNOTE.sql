CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_WORKERS_COMPENSATION_SAFETYTASKNOTE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_workers_compensation_safetytasknote 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.workers_compensation_safetytasknote  (SELECT t.$1 AS id, t.$2 AS created, t.$3 AS updated, t.$4 AS deleted, t.$5 AS originator_id, t.$6 AS last_updated_by_id, t.$7 AS deleted_by_id, t.$8 AS content, t.$9 AS author_id, t.$10 AS safety_task_id, t.$11 AS date_deleted, t.$12 AS agency_id, t.$13 AS franchisor_id, t.$14 AS SYS_CHANGE_VERSION, t.$15 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$15,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_workers_compensation_safetytasknote.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';