CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_SCHEDULES_SHIFT("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_schedules_shift 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.schedules_shift  (SELECT t.$1 AS id, t.$2 AS schedule_id, t.$3 AS patient_id, t.$4 AS caregiver_id, t.$5 AS created_old, t.$6 AS pay_rate_id, t.$7 AS bill_rate_id, t.$8 AS pay_rate_type, t.$9 AS pay_rate_custom_amount, t.$10 AS bill_rate_type, t.$11 AS bill_rate_custom_amount, t.$12 AS parent_id, t.$13 AS active, t.$14 AS unique_hash, t.$15 AS agency_id, t.$16 AS status, t.$17 AS scheduled, t.$18 AS pay_pro_rate, t.$19 AS bill_pro_rate, t.$20 AS authorization_id, t.$21 AS require_caregiver_confirmation, t.$22 AS in_facility, t.$23 AS rate_category_id, t.$24 AS updated, t.$25 AS deleted, t.$26 AS originator_id, t.$27 AS last_updated_by_id, t.$28 AS deleted_by_id, t.$29 AS created, t.$30 AS meta, t.$31 AS bill_tiered, t.$32 AS fcfs_enabled, t.$33 AS pay_rate_category_id, t.$34 AS pay_tiered, t.$35 AS shift_type, t.$36 AS date_deleted, t.$37 AS franchisor_id, t.$38 AS SYS_CHANGE_VERSION, t.$39 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$39,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_schedules_shift.*[.]csv.gz'') t);

   
    return ''Success'';
END;
';