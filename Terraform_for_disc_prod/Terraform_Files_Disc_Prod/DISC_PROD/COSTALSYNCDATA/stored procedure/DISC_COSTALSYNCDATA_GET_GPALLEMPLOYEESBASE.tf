resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_GPALLEMPLOYEESBASE" {
	name ="GET_GPALLEMPLOYEESBASE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_GpAllEmployeesBase 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_GpAllEmployeesBase FROM (SELECT t.$1 AS DB, t.$2 AS EMPLOYEE_ID, t.$3 AS INACTIVE, t.$4 AS SSN, t.$5 AS DEPARTMENT, t.$6 AS FIRST_NAME, t.$7 AS LAST_NAME, t.$8 AS MIDDLE_NAME, t.$9 AS LAST_CHECK_DATE, t.$10 AS ADDRESS_CODE, t.$11 AS ADDRESS1, t.$12 AS ADDRESS2, t.$13 AS ADDRESS3, t.$14 AS CITY, t.$15 AS STATE, t.$16 AS ZIP, t.$17 AS PHONE_NUMBER, t.$18 AS GENDER, t.$19 AS DOB, t.$20 AS HIRE_DATE, t.$21 AS BENEFIT_START_DATE, t.$22 AS TERMINATE_DATE, t.$23 AS GENDER_TEXT, t.$24 AS ETHICS, t.$25 AS SUTA_STATE, t.$26 AS VACATION_AVAILABLE, t.$27 AS SICK_AVAILABLE, t.$28 AS JOB_TITLE, t.$29 AS JOB_DESCRIPTION, t.$30 AS PHONE_NUMBER_2, t.$31 AS CLASS_ID, t.$32 AS ETHICS_CODE, t.$33 AS WORKERS_COMP, t.$34 AS REASON_TO_TERM, t.$35 AS LAST_DAY_WORKED, t.$36 AS MARITAL_STATUS, t.$37 AS MARITAL_STATUS_TEXT, t.$38 AS EMPLOYMENT_TYPE, t.$39 AS EMPLOYMENT_TYPE_TEXT, t.$40 AS FIRST_CHECK_DATE, t.$41 AS VACATION_ACCRUED, t.$42 AS SICK_ACCRUED, t.$43 AS IS_ADMIN, t.$44 AS DEPARTMENT_NAME, t.$45 AS EMAIL, t.$46 AS PERSONAL_EMAIL, t.$47 AS SYS_CHANGE_VERSION, t.$48 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$48,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_GpAllEmployeesBase.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GpAllEmployeesBase AS WITH curr_v AS (SELECT DB, EMPLOYEE_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_GpAllEmployeesBase GROUP BY DB, EMPLOYEE_ID) SELECT t.* FROM CostalSyncData.HIST_GpAllEmployeesBase t INNER JOIN curr_v v ON t.DB = v.DB AND t.EMPLOYEE_ID = v.EMPLOYEE_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

