CREATE OR REPLACE PROCEDURE DISC_PROD.AXXESS.GET_AXXESS_PATIENTINFO("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AXXESS.GET_AXXESS_PATIENTINFO 
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
    INSERT OVERWRITE INTO DISC_PROD.AXXESS.AXXESS_PATIENTINFO ( SELECT EI.$1 AS PATIENT_ID, EI.$2 AS MEDICAL_RECORD_NUMBER, EI.$3 AS LAST_NAME, EI.$4 AS FIRST_NAME, EI.$5 AS MIDDLE_INITIAL, EI.$6 AS SSN,EI.$7 AS DATE_OF_BIRTH, EI.$8 AS GENDER, EI.$9 AS ADDRESS, EI.$10 AS CITY, EI.$11 AS STATE, EI.$12 AS ZIP_CODE, EI.$13 AS REFERRAL_DATE, EI.$14 AS PHONE, EI.$15 AS EMERGENCY_CONTACT_PHONE, EI.$16 AS CASE_MANAGER_FIRST_NAME, EI.$17 AS CASE_MANAGER_LAST_NAME,EI.$18 AS RACE,EI.$19 AS ENTHNICITY,EI.$20 AS COMMENTS, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/PatientInfo(file_format => DISC_PROD.STAGE.PSV_FORMAT) EI );

    return ''Success'';
END;
';