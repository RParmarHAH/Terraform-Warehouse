resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_CPCARPLN" {
	name ="GET_CV_CPCARPLN"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_CV_cpcarpln 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_CV_cpcarpln FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS Patient_Number, t.$8 AS Admission_Number, t.$9 AS Care_Plan_Number, t.$10 AS Care_Plan_Description, t.$11 AS DDL_Clinic_Care_Plan_St, t.$12 AS Care_Plan_Start_Date, t.$13 AS Care_Plan_End_Date, t.$14 AS Signature_Array5_1, t.$15 AS Signature_Array5_2, t.$16 AS Signature_Array5_3, t.$17 AS Signature_Array5_4, t.$18 AS Signature_Array5_5, t.$19 AS Signature_Date_Array5_1, t.$20 AS Signature_Date_Array5_2, t.$21 AS Signature_Date_Array5_3, t.$22 AS Signature_Date_Array5_4, t.$23 AS Signature_Date_Array5_5, t.$24 AS CP_Care_Plan_Type_Code, t.$25 AS Next_Review_Date, t.$26 AS Last_Review_Date, t.$27 AS DDL_Care_Plan_Type, t.$28 AS Primary_Diagnosis, t.$29 AS DEX_ROW_ID, t.$30 AS SYS_CHANGE_VERSION, t.$31 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$31,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_cpcarpln.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_cpcarpln AS WITH curr_v AS (SELECT Db, Care_Plan_Number, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_cpcarpln GROUP BY Db, Care_Plan_Number) SELECT t.* FROM CostalSyncData.HIST_CV_cpcarpln t INNER JOIN curr_v v ON t.Db = v.Db AND t.Care_Plan_Number = v.Care_Plan_Number AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

