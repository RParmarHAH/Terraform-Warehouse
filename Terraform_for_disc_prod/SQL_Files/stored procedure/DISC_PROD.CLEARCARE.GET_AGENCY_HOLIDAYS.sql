CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_AGENCY_HOLIDAYS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_agency_holidays 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.agency_holidays  (SELECT t.$1 AS id, t.$2 AS agency_id, t.$3 AS holiday_id, t.$4 AS bill_multiplier, t.$5 AS pay_multiplier, t.$6 AS name, t.$7 AS the_date, t.$8 AS created, t.$9 AS updated, t.$10 AS deleted, t.$11 AS originator_id, t.$12 AS last_updated_by_id, t.$13 AS deleted_by_id, t.$14 AS date_deleted, t.$15 AS occurrence_id, t.$16 AS country_id, t.$17 AS description, t.$18 AS default_bill_multiplier, t.$19 AS default_pay_multiplier, t.$20 AS holiday_occurence, t.$21 AS holiday_name, t.$22 AS franchisor_id, t.$23 AS SYS_CHANGE_VERSION, t.$24 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$24,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_agency_holidays.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';