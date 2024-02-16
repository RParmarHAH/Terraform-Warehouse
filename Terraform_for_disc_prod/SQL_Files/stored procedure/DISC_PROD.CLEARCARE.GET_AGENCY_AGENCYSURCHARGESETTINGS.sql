CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_AGENCY_AGENCYSURCHARGESETTINGS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_agency_agencysurchargesettings 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.agency_agencysurchargesettings  (SELECT t.$1 AS id, t.$2 AS created, t.$3 AS updated, t.$4 AS deleted, t.$5 AS add_surcharge, t.$6 AS tax_surcharge, t.$7 AS label, t.$8 AS enable_for_new_clients, t.$9 AS apply_to_expenses, t.$10 AS apply_to_mileage, t.$11 AS apply_to_credits, t.$12 AS apply_to_visit_notes, t.$13 AS apply_to_interest, t.$14 AS rate, t.$15 AS type, t.$16 AS agency_id, t.$17 AS deleted_by_id, t.$18 AS last_updated_by_id, t.$19 AS originator_id, t.$20 AS franchisor_id, t.$21 AS SYS_CHANGE_VERSION, t.$22 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$22,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_agency_agencysurchargesettings.*[.]csv.gz'') t);

   
    return ''Success'';
END;
';