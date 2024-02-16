CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_AGENCY_AGENCYLOCATION("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_agency_agencylocation 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.agency_agencylocation  (SELECT t.$1 AS id, t.$2 AS name, t.$3 AS agency_id, t.$4 AS use_as_class, t.$5 AS updated, t.$6 AS created, t.$7 AS payroll_dept_code, t.$8 AS payroll_branch_id, t.$9 AS deleted, t.$10 AS originator_id, t.$11 AS last_updated_by_id, t.$12 AS deleted_by_id, t.$13 AS date_deleted, t.$14 AS address, t.$15 AS address_line_2, t.$16 AS city, t.$17 AS state, t.$18 AS zip, t.$19 AS phone_number, t.$20 AS fax_number, t.$21 AS cuid, t.$22 AS timezone, t.$23 AS is_default, t.$24 AS franchisor_id, t.$25 AS SYS_CHANGE_VERSION, t.$26 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$26,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_agency_agencylocation.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';