CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_CARELOGS_SIGNATURE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_carelogs_signature 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.carelogs_signature  (SELECT t.$1 AS id, t.$2 AS carelog_id, t.$3 AS cci_timestamp, t.$4 AS name, t.$5 AS source, t.$6 AS recording_sid, t.$7 AS recording_processed, t.$8 AS audio, t.$9 AS signature_type, t.$10 AS signed, t.$11 AS cci_signed_data, t.$12 AS created, t.$13 AS scanned_signature_file, t.$14 AS updated, t.$15 AS deleted, t.$16 AS originator_id, t.$17 AS last_updated_by_id, t.$18 AS deleted_by_id, t.$19 AS date_deleted, t.$20 AS agency_id, t.$21 AS franchisor_id, t.$22 AS SYS_CHANGE_VERSION, t.$23 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$23,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_carelogs_signature.*[.]csv.gz'') t);

   
    return ''Success'';
END;
';