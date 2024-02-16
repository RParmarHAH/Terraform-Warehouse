resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_ADMISSIONS" {
	name ="GET_CV_ADMISSIONS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_CV_Admissions 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_CV_Admissions FROM (SELECT t.$1 AS Db, t.$2 AS Entry_Date, t.$3 AS Update_Date, t.$4 AS Patient_Number, t.$5 AS Admission_Number, t.$6 AS Admit_Date, t.$7 AS Admit_Hour, t.$8 AS Verbal_SOC_Date, t.$9 AS Admission_Type_Code, t.$10 AS Admission_Source_Code, t.$11 AS Admitted_From_Code, t.$12 AS Primary_Physician, t.$13 AS Nurse_ID, t.$14 AS Bill_Classification_Code, t.$15 AS Admit_Diagnosis3_1, t.$16 AS Diagnosis9_1, t.$17 AS Diagnosis9_2, t.$18 AS Diagnosis9_3, t.$19 AS Discharge_Code, t.$20 AS Discharge_Date, t.$21 AS Discharge_Time, t.$22 AS Department__Code, t.$23 AS Primary_Plan, t.$24 AS Facility_Code, t.$25 AS Referring_Source_Code, t.$26 AS Location_Name, t.$27 AS DRG_Code, t.$28 AS Location_Code, t.$29 AS Billto_Status_Code, t.$30 AS ICD_Code, t.$31 AS Current_Billto_Stat_Code, t.$32 AS Current_Plan_Code, t.$33 AS Room_Number, t.$34 AS Bed_Number, t.$35 AS DEX_ROW_ID, t.$36 AS SYS_CHANGE_VERSION, t.$37 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$37,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_Admissions.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_Admissions AS WITH curr_v AS (SELECT Db, Admission_Number, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_Admissions GROUP BY Db, Admission_Number) SELECT t.* FROM CostalSyncData.HIST_CV_Admissions t INNER JOIN curr_v v ON t.Db = v.Db AND t.Admission_Number = v.Admission_Number AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

