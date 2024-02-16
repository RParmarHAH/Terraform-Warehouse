resource "snowflake_procedure" "DISC_GPSYNCDATA_GET_GPALLEMPLOYEESBASE" {
	name ="GET_GPALLEMPLOYEESBASE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GpSyncData.GET_GpAllEmployeesBase 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.GpSyncData.HIST_GpAllEmployeesBase FROM (SELECT t.$1 AS DB, t.$2 AS EMPLOYEE_ID, t.$3 AS INACTIVE, t.$4 AS SSN, t.$5 AS DEPARTMENT, t.$6 AS WORK_STATE, t.$7 AS OFFICE, t.$8 AS IS_ADMIN, t.$9 AS FIRST_NAME, t.$10 AS LAST_NAME, t.$11 AS MIDDLE_NAME, t.$12 AS CONTRACT_TYPE, t.$13 AS LAST_CHECK_DATE, t.$14 AS ADDRESS_CODE, t.$15 AS ADDRESS1, t.$16 AS ADDRESS2, t.$17 AS ADDRESS3, t.$18 AS CITY, t.$19 AS STATE, t.$20 AS ZIP, t.$21 AS PHONE_NUMBER, t.$22 AS SHORT_EMPLOYEE_ID, t.$23 AS GENDER, t.$24 AS DOB, t.$25 AS HIRE_DATE, t.$26 AS BENEFIT_START_DATE, t.$27 AS TERMINATE_DATE, t.$28 AS GENDER_TEXT, t.$29 AS ETHICS, t.$30 AS SUTA_STATE, t.$31 AS VACATION_AVAILABLE, t.$32 AS SICK_AVAILABLE, t.$33 AS JOB_TITLE, t.$34 AS JOB_DESCRIPTION, t.$35 AS PHONE_NUMBER_2, t.$36 AS CLASS_ID, t.$37 AS ETHICS_CODE, t.$38 AS WORKERS_COMP, t.$39 AS REASON_TO_TERM, t.$40 AS LAST_DAY_WORKED, t.$41 AS OFFICE_STATE, t.$42 AS OFFICE_NO, t.$43 AS REPLACEMENTS, t.$44 AS MARITAL_STATUS, t.$45 AS MARITAL_STATUS_TEXT, t.$46 AS EMPLOYMENT_TYPE, t.$47 AS EMPLOYMENT_TYPE_TEXT, t.$48 AS FIRST_CHECK_DATE, t.$49 AS VACATION_ACCRUED, t.$50 AS SICK_ACCRUED, t.$51 AS DEPARTMENT_NAME, t.$52 AS EMAIL, t.$53 AS PTO_Code, t.$54 AS PERSONAL_EMAIL, t.$55 AS SYS_CHANGE_VERSION, t.$56 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$56,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GPSYNCDATA/ (PATTERN => ''.*GpSyncData_dbo_GpAllEmployeesBase.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GpSyncData.GpAllEmployeesBase AS WITH curr_v AS (SELECT DB, EMPLOYEE_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GpSyncData.HIST_GpAllEmployeesBase GROUP BY DB, EMPLOYEE_ID) SELECT t.* FROM GpSyncData.HIST_GpAllEmployeesBase t INNER JOIN curr_v v ON t.DB = v.DB AND t.EMPLOYEE_ID = v.EMPLOYEE_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

