resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_MEDICATIONTABLES" {
	name ="GET_CV_MEDICATIONTABLES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_CV_MedicationTables 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_CV_MedicationTables FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS Medication_Code, t.$8 AS Medication_Description, t.$9 AS Medication_Dose, t.$10 AS Route_Number, t.$11 AS Medication_Frequency, t.$12 AS Form, t.$13 AS Medication_Category, t.$14 AS Medication_NDC_Number, t.$15 AS Cost, t.$16 AS Order_Type, t.$17 AS Firm_Number, t.$18 AS DDL_RxOTC, t.$19 AS FDB_MED_STATUS_CD, t.$20 AS FDB_MED_STREN, t.$21 AS FDB_MED_STREN_UOM, t.$22 AS FDB_GCN_SEQNO, t.$23 AS FDB_GTC, t.$24 AS DDL_SRC, t.$25 AS CB_SQL_Upgrade_01, t.$26 AS FDB_MEDID, t.$27 AS DEX_ROW_ID, t.$28 AS SYS_CHANGE_VERSION, t.$29 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$29,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_MedicationTables.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_MedicationTables AS WITH curr_v AS (SELECT Db, Medication_Code, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_MedicationTables GROUP BY Db, Medication_Code) SELECT t.* FROM CostalSyncData.HIST_CV_MedicationTables t INNER JOIN curr_v v ON t.Db = v.Db AND t.Medication_Code = v.Medication_Code AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

