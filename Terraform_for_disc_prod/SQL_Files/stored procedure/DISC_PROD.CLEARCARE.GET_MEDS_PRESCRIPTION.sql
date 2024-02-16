CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_MEDS_PRESCRIPTION("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_meds_prescription 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.meds_prescription  (SELECT t.$1 AS id, t.$2 AS client_id, t.$3 AS drug_product_id, t.$4 AS active, t.$5 AS supplement_name, t.$6 AS supplement_form, t.$7 AS amount, t.$8 AS schedule_kind, t.$9 AS reason_description, t.$10 AS last_modified, t.$11 AS notes, t.$12 AS schedule, t.$13 AS creator_id, t.$14 AS drug_product_custom_dosage, t.$15 AS created, t.$16 AS updated, t.$17 AS deleted, t.$18 AS originator_id, t.$19 AS last_updated_by_id, t.$20 AS deleted_by_id, t.$21 AS date_deleted, t.$22 AS agency_id, t.$23 AS franchisor_id, t.$24 AS SYS_CHANGE_VERSION, t.$25 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$25,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_meds_prescription.*[.]csv.gz'') t);

   
    return ''Success'';
END;
';