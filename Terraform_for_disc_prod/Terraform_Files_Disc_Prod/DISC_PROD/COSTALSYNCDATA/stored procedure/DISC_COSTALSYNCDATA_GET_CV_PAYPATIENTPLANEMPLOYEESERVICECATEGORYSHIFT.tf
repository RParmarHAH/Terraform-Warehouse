resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_PAYPATIENTPLANEMPLOYEESERVICECATEGORYSHIFT" {
	name ="GET_CV_PAYPATIENTPLANEMPLOYEESERVICECATEGORYSHIFT"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_CV_PayPatientPlanEmployeeServiceCategoryShift 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_CV_PayPatientPlanEmployeeServiceCategoryShift FROM (SELECT t.$1 AS Db, t.$2 AS Entry_User, t.$3 AS Entry_Date, t.$4 AS Update_User, t.$5 AS Update_Date, t.$6 AS Start_Date, t.$7 AS End_Date, t.$8 AS DDL_Pat_Plan, t.$9 AS Patient_Number, t.$10 AS Plan_Code, t.$11 AS Nurse_ID, t.$12 AS Service_Category_Code, t.$13 AS Shift_Code, t.$14 AS Base_Rate, t.$15 AS Weekday_Payrate_Type, t.$16 AS Weekend_Payrate_Type, t.$17 AS Weekend_Payrate, t.$18 AS Holiday_PayrateType_Arr3_1, t.$19 AS Holiday_PayrateType_Arr3_2, t.$20 AS Holiday_PayrateType_Arr3_3, t.$21 AS Holiday_Payrate_Arr3_1, t.$22 AS Holiday_Payrate_Arr3_2, t.$23 AS Holiday_Payrate_Arr3_3, t.$24 AS Row_ID, t.$25 AS SYS_CHANGE_VERSION, t.$26 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$26,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_PayPatientPlanEmployeeServiceCategoryShift.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_PayPatientPlanEmployeeServiceCategoryShift AS WITH curr_v AS (SELECT Db, Row_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_PayPatientPlanEmployeeServiceCategoryShift GROUP BY Db, Row_ID) SELECT t.* FROM CostalSyncData.HIST_CV_PayPatientPlanEmployeeServiceCategoryShift t INNER JOIN curr_v v ON t.Db = v.Db AND t.Row_ID = v.Row_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

