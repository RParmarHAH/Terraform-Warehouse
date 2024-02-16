CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_ASSESSMENT_CLIENTACTIVITY("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_assessment_clientactivity 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.assessment_clientactivity  (SELECT t.$1 AS id, t.$2 AS created, t.$3 AS updated, t.$4 AS client_id, t.$5 AS activity_id, t.$6 AS score, t.$7 AS notes, t.$8 AS deleted, t.$9 AS originator_id, t.$10 AS last_updated_by_id, t.$11 AS deleted_by_id, t.$12 AS date_deleted, t.$13 AS agency_id, t.$14 AS franchisor_id, t.$15 AS SYS_CHANGE_VERSION, t.$16 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$16,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_assessment_clientactivity.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';