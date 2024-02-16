CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_PROFILE_RECEIVABLESBALANCE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_profile_receivablesbalance 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.profile_receivablesbalance  (SELECT t.$1 AS created, t.$2 AS updated, t.$3 AS profile_id, t.$4 AS unpaid_invoices, t.$5 AS deposits, t.$6 AS cci_current, t.$7 AS zero_thirty, t.$8 AS thirty_sixty, t.$9 AS sixty_ninety, t.$10 AS ninety_plus, t.$11 AS total, t.$12 AS deleted, t.$13 AS originator_id, t.$14 AS last_updated_by_id, t.$15 AS deleted_by_id, t.$16 AS current_balance, t.$17 AS current_balance_including_deposits, t.$18 AS date_deleted, t.$19 AS agency_id, t.$20 AS franchisor_id, t.$21 AS SYS_CHANGE_VERSION, t.$22 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$22,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_profile_receivablesbalance.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';