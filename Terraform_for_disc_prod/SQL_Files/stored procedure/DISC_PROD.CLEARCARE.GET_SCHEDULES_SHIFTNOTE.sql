CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_SCHEDULES_SHIFTNOTE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_schedules_shiftnote 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.schedules_shiftnote  (SELECT t.$1 AS id, t.$2 AS shift_id, t.$3 AS carelog_id, t.$4 AS cci_date, t.$5 AS note, t.$6 AS show_with_billing, t.$7 AS show_with_payroll, t.$8 AS updated, t.$9 AS created, t.$10 AS deleted, t.$11 AS originator_id, t.$12 AS last_updated_by_id, t.$13 AS deleted_by_id, t.$14 AS unavailability_id, t.$15 AS is_for_all_occurrence, t.$16 AS date_deleted, t.$17 AS agency_id, t.$18 AS franchisor_id, t.$19 AS SYS_CHANGE_VERSION, t.$20 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$20,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_schedules_shiftnote.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';