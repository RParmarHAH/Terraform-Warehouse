CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_PROFILE_PARENTPAYERSERVICE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_profile_parentpayerservice 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.profile_parentpayerservice  (SELECT t.$1 AS id, t.$2 AS created, t.$3 AS updated, t.$4 AS parent_payer_id, t.$5 AS cms_procedure_id, t.$6 AS provider_id, t.$7 AS procedure_code, t.$8 AS modifier1, t.$9 AS service_name, t.$10 AS modifier2, t.$11 AS modifier3, t.$12 AS modifier4, t.$13 AS qualifier, t.$14 AS rendering_provider_npi, t.$15 AS deleted, t.$16 AS originator_id, t.$17 AS last_updated_by_id, t.$18 AS deleted_by_id, t.$19 AS procedure_code_description, t.$20 AS evv_mandated, t.$21 AS date_deleted, t.$22 AS agency_id, t.$23 AS program, t.$24 AS svc, t.$25 AS qualifier_24i, t.$26 AS franchisor_id, t.$27 AS SYS_CHANGE_VERSION, t.$28 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$28,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_profile_parentpayerservice.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';