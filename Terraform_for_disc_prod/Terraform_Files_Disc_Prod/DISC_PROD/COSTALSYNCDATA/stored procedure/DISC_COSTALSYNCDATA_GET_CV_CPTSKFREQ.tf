resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_CPTSKFREQ" {
	name ="GET_CV_CPTSKFREQ"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_CV_cptskfreq 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_CV_cptskfreq FROM (SELECT t.$1 AS Db, t.$2 AS Care_Plan_Number, t.$3 AS Clinical_Task_Ctg_Code, t.$4 AS Clinical_Task_Code, t.$5 AS CB_Sunday, t.$6 AS CB_Monday, t.$7 AS CB_Tuesday, t.$8 AS CB_Wednesday, t.$9 AS CB_Thursday, t.$10 AS CB_Friday, t.$11 AS CB_Saturday, t.$12 AS CB_Daily_Every, t.$13 AS CB_Daily_Every_Weekday, t.$14 AS RB_Pattern_Type, t.$15 AS Times_Per_Day, t.$16 AS No_of_Times_Per_Freq, t.$17 AS Recur_Every, t.$18 AS Number_of_Every_Hour, t.$19 AS CB_PRN_Frequency, t.$20 AS PRN_Frequency, t.$21 AS DDL_PRN_Frequency_Type, t.$22 AS RecStat, t.$23 AS Entry_User, t.$24 AS Entry_Date, t.$25 AS Update_User, t.$26 AS Update_Date, t.$27 AS SYS_CHANGE_VERSION, t.$28 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$28,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_cptskfreq.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_cptskfreq AS WITH curr_v AS (SELECT Db, Care_Plan_Number, Clinical_Task_Code, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_cptskfreq GROUP BY Db, Care_Plan_Number, Clinical_Task_Code) SELECT t.* FROM CostalSyncData.HIST_CV_cptskfreq t INNER JOIN curr_v v ON t.Db = v.Db AND t.Care_Plan_Number = v.Care_Plan_Number AND t.Clinical_Task_Code = v.Clinical_Task_Code AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

