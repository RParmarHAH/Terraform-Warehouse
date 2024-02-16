resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_MDGUADAT" {
	name ="GET_CV_MDGUADAT"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_CV_MDGUADAT 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_CV_MDGUADAT FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS Guarantor_Number, t.$8 AS Last_Name, t.$9 AS First_Name, t.$10 AS Middle_Initial, t.$11 AS Address, t.$12 AS Street_Name, t.$13 AS City, t.$14 AS STATE_CODE, t.$15 AS Zipcode, t.$16 AS Social_Security_Number, t.$17 AS Birth_Date, t.$18 AS Sex, t.$19 AS Salute, t.$20 AS Phone_Number, t.$21 AS Emergency_Phone, t.$22 AS Contact_Person, t.$23 AS Email, t.$24 AS Billto_Status_Code, t.$25 AS Location_Code, t.$26 AS Open_Item_Bal_Forward, t.$27 AS Statement, t.$28 AS Statement_Cycle, t.$29 AS No_Statement_Date, t.$30 AS Restatement, t.$31 AS Statement_Days, t.$32 AS Guarantor_Sign_on_File, t.$33 AS Auot_Selfpay, t.$34 AS Auto_Selfpay_Days, t.$35 AS Auto_Adjustment, t.$36 AS Minimum_Balance, t.$37 AS Dunning_Message, t.$38 AS No_Message_Date, t.$39 AS Message_Code, t.$40 AS CREDITSTAT_CODE, t.$41 AS Employer_Code, t.$42 AS Employer_Name, t.$43 AS Employer_Street, t.$44 AS Address_2, t.$45 AS Employer_City, t.$46 AS Employer_State, t.$47 AS Employer_Zipcode, t.$48 AS Employer_Phone, t.$49 AS Extension_Number, t.$50 AS Employment_Email, t.$51 AS Employer_Contact, t.$52 AS Contact_Phone, t.$53 AS Employer_Contact_Extn, t.$54 AS Employer_Contact_Email, t.$55 AS Business_Type, t.$56 AS Finance_Chaarge, t.$57 AS Unused_Integer, t.$58 AS Rebill_Charge, t.$59 AS Rebill_charge_Rate, t.$60 AS Total_Charge, t.$61 AS Total_Payment, t.$62 AS Total_Adjustment, t.$63 AS Last_Charge_Date, t.$64 AS Last_Payment_Date, t.$65 AS Last_Adjustment_Date, t.$66 AS Last_Statement_Date, t.$67 AS Last_Claim_Date, t.$68 AS Last_BillTo_Date, t.$69 AS Employment_Status_Code, t.$70 AS Total_Contractual, t.$71 AS Finance_Charge_Metho, t.$72 AS Finance_Charge_Rate, t.$73 AS Interface_Guarantor_ID, t.$74 AS Occupation__Code, t.$75 AS Guarantor_Contact, t.$76 AS Refering_Patient, t.$77 AS RECALLRESN_CODE, t.$78 AS Recall_Days, t.$79 AS Last_Recall_Date, t.$80 AS Recall_Note, t.$81 AS CRLF, t.$82 AS Cell_Phone, t.$83 AS DEX_ROW_ID, t.$84 AS SYS_CHANGE_VERSION, t.$85 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$85,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_MDGUADAT.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_MDGUADAT AS WITH curr_v AS (SELECT Db, Guarantor_Number, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_MDGUADAT GROUP BY Db, Guarantor_Number) SELECT t.* FROM CostalSyncData.HIST_CV_MDGUADAT t INNER JOIN curr_v v ON t.Db = v.Db AND t.Guarantor_Number = v.Guarantor_Number AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

