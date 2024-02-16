resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_MDPPRDET" {
	name ="GET_CV_MDPPRDET"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_CV_mdpprdet 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_CV_mdpprdet FROM (SELECT t.$1 AS Db, t.$2 AS Plan_Code, t.$3 AS ProcCode, t.$4 AS Plan_Procedure_Code, t.$5 AS Plan_Proc_Description, t.$6 AS Charge_Amount, t.$7 AS Approved_Amount, t.$8 AS Use_Approved, t.$9 AS Charge_Adjustment, t.$10 AS Payment_Amount, t.$11 AS Ppr_Payment_Method, t.$12 AS Print_App_Amt, t.$13 AS CB_Cert_Required, t.$14 AS Filler_43, t.$15 AS Entry_User, t.$16 AS Entry_Date, t.$17 AS Update_User, t.$18 AS Update_Date, t.$19 AS CRLF, t.$20 AS DDL_Charge_Amount_Source, t.$21 AS DDL_Approved_Amt_Source, t.$22 AS Approved_Amount_Discount, t.$23 AS DEX_ROW_ID, t.$24 AS SYS_CHANGE_VERSION, t.$25 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$25,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_mdpprdet.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_mdpprdet AS WITH curr_v AS (SELECT Db, Plan_Code, ProcCode, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_mdpprdet GROUP BY Db, Plan_Code, ProcCode) SELECT t.* FROM CostalSyncData.HIST_CV_mdpprdet t INNER JOIN curr_v v ON t.Db = v.Db AND t.Plan_Code = v.Plan_Code AND t.ProcCode = v.ProcCode AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

