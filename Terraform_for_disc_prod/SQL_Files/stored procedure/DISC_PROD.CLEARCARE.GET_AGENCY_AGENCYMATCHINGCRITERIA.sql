CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_AGENCY_AGENCYMATCHINGCRITERIA("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_agency_agencymatchingcriteria 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.agency_agencymatchingcriteria  (SELECT t.$1 AS id, t.$2 AS created, t.$3 AS updated, t.$4 AS agency_id, t.$5 AS name, t.$6 AS help_notes, t.$7 AS category, t.$8 AS built_in_type, t.$9 AS certification_id, t.$10 AS active, t.$11 AS show_on_apply, t.$12 AS deleted, t.$13 AS originator_id, t.$14 AS last_updated_by_id, t.$15 AS deleted_by_id, t.$16 AS franchisor_id, t.$17 AS SYS_CHANGE_VERSION, t.$18 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$18,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_agency_agencymatchingcriteria.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';