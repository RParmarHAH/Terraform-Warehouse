resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_PLANS" {
	name ="GET_CV_PLANS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_CV_Plans 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_CV_Plans FROM (SELECT t.$1 AS DB, t.$2 AS Entry_Date, t.$3 AS Update_Date, t.$4 AS Plan_Code, t.$5 AS Plan_Name, t.$6 AS Address, t.$7 AS Street_Name, t.$8 AS City, t.$9 AS STATE_CODE, t.$10 AS Zipcode, t.$11 AS Phone, t.$12 AS Extension_Number, t.$13 AS Contact_Person, t.$14 AS Insurance_Type, t.$15 AS Claim_Form_Code, t.$16 AS Accept_Assignment, t.$17 AS Approved_Write_Off, t.$18 AS Payment_Code, t.$19 AS Electronic_Claim, t.$20 AS Format_Code, t.$21 AS Payor_ID, t.$22 AS Payor_Sub_ID, t.$23 AS Source_of_Payment, t.$24 AS Group_by_TOS, t.$25 AS Group_by_POS, t.$26 AS Claim, t.$27 AS Claim_Payment_Type, t.$28 AS Billto_Status_Code, t.$29 AS Procedure_Coding, t.$30 AS CB_Zero_Bal_Claims, t.$31 AS CB_Credit_Bal_Claims, t.$32 AS CB_Claim_By_Procedure, t.$33 AS CB_Claim_By_Proc_Serv_Dt, t.$34 AS DDL_Group_By_Authorizati, t.$35 AS EMC_Format_Code, t.$36 AS DDL_Copay_Option, t.$37 AS DDL_Rounding_Program, t.$38 AS CB_Check_Frequency, t.$39 AS CB_Claim_By_Bill, t.$40 AS DEX_ROW_ID, t.$41 AS SYS_CHANGE_VERSION, t.$42 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$42,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_Plans.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_Plans AS WITH curr_v AS (SELECT DB, Plan_Code, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_Plans GROUP BY DB, Plan_Code) SELECT t.* FROM CostalSyncData.HIST_CV_Plans t INNER JOIN curr_v v ON t.DB = v.DB AND t.Plan_Code = v.Plan_Code AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

