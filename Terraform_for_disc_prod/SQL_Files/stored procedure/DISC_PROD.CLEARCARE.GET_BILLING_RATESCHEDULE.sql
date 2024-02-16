CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_BILLING_RATESCHEDULE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_billing_rateschedule 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.billing_rateschedule  (SELECT t.$1 AS id, t.$2 AS updated, t.$3 AS created, t.$4 AS agency_id, t.$5 AS rate_type, t.$6 AS name, t.$7 AS bill_amount, t.$8 AS pay_amount, t.$9 AS payroll_code, t.$10 AS pro_rate, t.$11 AS active, t.$12 AS rate_category_id, t.$13 AS rate_dept_code, t.$14 AS deleted, t.$15 AS originator_id, t.$16 AS last_updated_by_id, t.$17 AS deleted_by_id, t.$18 AS meta, t.$19 AS date_deleted, t.$20 AS franchisor_id, t.$21 AS SYS_CHANGE_VERSION, t.$22 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$22,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_billing_rateschedule.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';