resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_LOCATIONS" {
	name ="GET_CV_LOCATIONS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_CV_Locations 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_CV_Locations FROM (SELECT t.$1 AS DB, t.$2 AS Entry_Date, t.$3 AS Update_Date, t.$4 AS Location_Code, t.$5 AS Location_Name, t.$6 AS Address, t.$7 AS Street_Name, t.$8 AS City, t.$9 AS STATE_CODE, t.$10 AS Zipcode, t.$11 AS Employer_Id_Number, t.$12 AS Claim_Form_Code, t.$13 AS Statement_Form_Code, t.$14 AS Noshow_Days, t.$15 AS History_Days, t.$16 AS From_Time, t.$17 AS Thru_Time, t.$18 AS TSR_Form, t.$19 AS Duration, t.$20 AS EMC_Site_Code, t.$21 AS Taxonomy_Code, t.$22 AS NPI, t.$23 AS DEX_ROW_ID, t.$24 AS SYS_CHANGE_VERSION, t.$25 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$25,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_Locations.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_Locations AS WITH curr_v AS (SELECT DB, Location_Code, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_Locations GROUP BY DB, Location_Code) SELECT t.* FROM CostalSyncData.HIST_CV_Locations t INNER JOIN curr_v v ON t.DB = v.DB AND t.Location_Code = v.Location_Code AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

