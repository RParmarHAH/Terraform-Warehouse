CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_PATIENT_PATIENTREPORTCHECKLIST("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_patient_patientreportchecklist 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.patient_patientreportchecklist  (SELECT t.$1 AS id, t.$2 AS report_id, t.$3 AS caregiver_id, t.$4 AS signed_off, t.$5 AS friday_reminder_sent, t.$6 AS monday_reminder_sent, t.$7 AS created, t.$8 AS updated, t.$9 AS deleted, t.$10 AS originator_id, t.$11 AS last_updated_by_id, t.$12 AS deleted_by_id, t.$13 AS date_deleted, t.$14 AS agency_id, t.$15 AS franchisor_id, t.$16 AS SYS_CHANGE_VERSION, t.$17 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$17,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_patient_patientreportchecklist.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';