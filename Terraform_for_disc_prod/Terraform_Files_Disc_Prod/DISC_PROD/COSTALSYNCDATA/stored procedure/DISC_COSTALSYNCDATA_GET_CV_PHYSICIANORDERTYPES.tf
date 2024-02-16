resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_PHYSICIANORDERTYPES" {
	name ="GET_CV_PHYSICIANORDERTYPES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_CV_PhysicianOrderTypes 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_CV_PhysicianOrderTypes FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Order_Type, t.$4 AS Order_Type_Description, t.$5 AS DDL_Order_Type_Group, t.$6 AS CB_Quantity, t.$7 AS Filler_182, t.$8 AS Entry_User, t.$9 AS Entry_Date, t.$10 AS Update_User, t.$11 AS Update_Date, t.$12 AS CRLF, t.$13 AS CB_RFB, t.$14 AS CB_Dose, t.$15 AS CB_Route, t.$16 AS CB_Frequency, t.$17 AS CB_Visit_Frequency, t.$18 AS CB_Instruction, t.$19 AS CB_Insert_Order_Desc, t.$20 AS CB_Insert_Dose_Desc, t.$21 AS CB_Insert_Route_Desc, t.$22 AS CB_Insert_Frequency_Desc, t.$23 AS CB_Insert_Visit_Frequenc, t.$24 AS CB_Insert_Instruction_De, t.$25 AS DDL_Referral_Out, t.$26 AS CB_Procedure, t.$27 AS CB_Discipline_Frequency, t.$28 AS CP_Note_Type, t.$29 AS Referral_Type_Code, t.$30 AS Display_Sequence, t.$31 AS DDL_Order_Print_Option, t.$32 AS DEX_ROW_ID, t.$33 AS SYS_CHANGE_VERSION, t.$34 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$34,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_PhysicianOrderTypes.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_PhysicianOrderTypes AS WITH curr_v AS (SELECT Db, Order_Type, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_PhysicianOrderTypes GROUP BY Db, Order_Type) SELECT t.* FROM CostalSyncData.HIST_CV_PhysicianOrderTypes t INNER JOIN curr_v v ON t.Db = v.Db AND t.Order_Type = v.Order_Type AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

