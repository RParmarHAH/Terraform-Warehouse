resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_BILLINGTRANSACTIONS" {
	name ="GET_CV_BILLINGTRANSACTIONS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_CV_BillingTransactions 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_CV_BillingTransactions FROM (SELECT t.$1 AS Db, t.$2 AS Entry_Date, t.$3 AS Update_Date, t.$4 AS Patient_Number, t.$5 AS Bill_Number, t.$6 AS Bill_Date, t.$7 AS Batch_Number, t.$8 AS Super_Bill_Number, t.$9 AS Provider_Code, t.$10 AS Billto_Status_Code, t.$11 AS Plan_Code, t.$12 AS Referring_Source_Code, t.$13 AS Location_Code, t.$14 AS CB_Pre_Authorized, t.$15 AS Pre_Authorization_Number, t.$16 AS Pre_Authorization_Date, t.$17 AS CB_Conv_Auth_To_Bill, t.$18 AS Diagnosis1, t.$19 AS Diagnosis2, t.$20 AS Diagnosis3, t.$21 AS Diagnosis4, t.$22 AS Diagnosis5, t.$23 AS Diagnosis6, t.$24 AS Extended_Diagnosis1, t.$25 AS Extended_Diagnosis2, t.$26 AS Extended_Diagnosis3, t.$27 AS Extended_Diagnosis4, t.$28 AS Extended_Diagnosis5, t.$29 AS Extended_Diagnosis6, t.$30 AS Bill_Note1, t.$31 AS Bill_Note2, t.$32 AS Bill_Amount, t.$33 AS Payment_Amount, t.$34 AS Adjustment_Amount, t.$35 AS Plan_Charge, t.$36 AS Patient_Charge, t.$37 AS Last_Payment_Date, t.$38 AS Last_Adjustment_Date, t.$39 AS Last_BillTo_Date, t.$40 AS Last_Statement_Date, t.$41 AS Last_Claim_Date, t.$42 AS Claim_Status, t.$43 AS Statement_Status, t.$44 AS Bill_Type, t.$45 AS Journal_Number, t.$46 AS Resubmission, t.$47 AS Resubmission_Number, t.$48 AS Facility_Code, t.$49 AS Number_Of_Visit, t.$50 AS Co_payment__Charge, t.$51 AS Admission_Number, t.$52 AS Group_Code, t.$53 AS CB_Assignment_Complete, t.$54 AS Department__Code, t.$55 AS Sequence_Number, t.$56 AS Posting_Status, t.$57 AS Contractual_Pmt_Number, t.$58 AS Post_Date, t.$59 AS Sales_Tax, t.$60 AS CB_Hold_Bill, t.$61 AS CB_Use_Bill_Prov_For_Clm, t.$62 AS CB_Exclude_Management_Fe, t.$63 AS Schedule_Number, t.$64 AS Transfer_Number, t.$65 AS Bill_Adjustment_Number, t.$66 AS CB_Co_Pay_Transfer, t.$67 AS DDL_Charge_Source, t.$68 AS Credit_Bill_Number, t.$69 AS Debit_Bill_Number, t.$70 AS Transaction_Number, t.$71 AS Unified_Transaction_Num, t.$72 AS Charge_Adjustment_Amount, t.$73 AS Bill_Classification_Code, t.$74 AS Referring_Physician_Code, t.$75 AS DDL_Bill_Type, t.$76 AS Certification_Code, t.$77 AS Bill_Count, t.$78 AS Program_Code, t.$79 AS CB_Deleted, t.$80 AS Interface_Bill_Number, t.$81 AS Referral_In_Number, t.$82 AS Sales_Order_Number, t.$83 AS Rental_Order_Number, t.$84 AS Cert_Tran_Number, t.$85 AS CP_Clinical_Note_Number, t.$86 AS Illness_Date, t.$87 AS Similar_Symptom_Date, t.$88 AS CB_Employment_Related, t.$89 AS DDL_Accident_Type, t.$90 AS Accident_Code, t.$91 AS Accident_Date, t.$92 AS Accident_Time, t.$93 AS STATE_CODE, t.$94 AS Disabled_From, t.$95 AS Disabled_Thru, t.$96 AS Disability_Code, t.$97 AS Partial_Disability_From, t.$98 AS Partial_Disability, t.$99 AS Return_to_Work, t.$100 AS Outside_Lab_Code, t.$101 AS ProcCode, t.$102 AS Outside_Lab_Charge, t.$103 AS Charge_Source_ID, t.$104 AS DEX_ROW_ID, t.$105 AS SYS_CHANGE_VERSION, t.$106 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$106,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_BillingTransactions.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_BillingTransactions AS WITH curr_v AS (SELECT Db, Patient_Number, Bill_Number, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_BillingTransactions GROUP BY Db, Patient_Number, Bill_Number) SELECT t.* FROM CostalSyncData.HIST_CV_BillingTransactions t INNER JOIN curr_v v ON t.Db = v.Db AND t.Patient_Number = v.Patient_Number AND t.Bill_Number = v.Bill_Number AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

