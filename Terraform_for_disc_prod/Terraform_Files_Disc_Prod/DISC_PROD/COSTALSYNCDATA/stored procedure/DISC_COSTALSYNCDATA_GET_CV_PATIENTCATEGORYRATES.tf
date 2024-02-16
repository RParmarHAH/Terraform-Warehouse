resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_PATIENTCATEGORYRATES" {
	name ="GET_CV_PATIENTCATEGORYRATES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_CV_PatientCategoryRates 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_CV_PatientCategoryRates FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Patient_Number, t.$4 AS Nurse_ID, t.$5 AS Service_Category_Code, t.$6 AS Plan_Code, t.$7 AS Shift_Code, t.$8 AS Weekday_Procedure, t.$9 AS Weekend_Procedure, t.$10 AS Weekday_Payrate_Type, t.$11 AS Weekday_Payrate, t.$12 AS Weekend_Payrate_Type, t.$13 AS Weekend_Payrate, t.$14 AS Holiday_Type_Arr3_1, t.$15 AS Holiday_Type_Arr3_2, t.$16 AS Holiday_Type_Arr3_3, t.$17 AS Holiday_Procedure_Arr3_1, t.$18 AS Holiday_Procedure_Arr3_2, t.$19 AS Holiday_Procedure_Arr3_3, t.$20 AS Holiday_PayrateType_Arr3_1, t.$21 AS Holiday_PayrateType_Arr3_2, t.$22 AS Holiday_PayrateType_Arr3_3, t.$23 AS Holiday_Payrate_Arr3_1, t.$24 AS Holiday_Payrate_Arr3_2, t.$25 AS Holiday_Payrate_Arr3_3, t.$26 AS Filler_130, t.$27 AS Entry_User, t.$28 AS Entry_Date, t.$29 AS Update_User, t.$30 AS Update_Date, t.$31 AS CRLF, t.$32 AS DEX_ROW_ID, t.$33 AS SYS_CHANGE_VERSION, t.$34 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$34,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_PatientCategoryRates.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_PatientCategoryRates AS WITH curr_v AS (SELECT Db, Patient_Number, Nurse_ID, Service_Category_Code, Plan_Code, Shift_Code, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_PatientCategoryRates GROUP BY Db, Patient_Number, Nurse_ID, Service_Category_Code, Plan_Code, Shift_Code) SELECT t.* FROM CostalSyncData.HIST_CV_PatientCategoryRates t INNER JOIN curr_v v ON t.Db = v.Db AND t.Patient_Number = v.Patient_Number AND t.Nurse_ID = v.Nurse_ID AND t.Service_Category_Code = v.Service_Category_Code AND t.Plan_Code = v.Plan_Code AND t.Shift_Code = v.Shift_Code AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

