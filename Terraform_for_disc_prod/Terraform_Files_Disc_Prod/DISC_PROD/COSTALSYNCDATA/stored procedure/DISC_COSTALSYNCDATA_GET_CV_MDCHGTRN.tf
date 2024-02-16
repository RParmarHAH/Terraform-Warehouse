resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_MDCHGTRN" {
	name ="GET_CV_MDCHGTRN"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_cv_mdchgtrn 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_cv_mdchgtrn FROM (SELECT t.$1 AS DB, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS CRLF, t.$8 AS Patient_Number, t.$9 AS Service_Date, t.$10 AS Bill_Number, t.$11 AS Sequence_Number, t.$12 AS Service_Thru_Date, t.$13 AS Provider_Code, t.$14 AS Billto_Status_Code, t.$15 AS Plan_Code, t.$16 AS ProcCode, t.$17 AS Number_Of_Unit, t.$18 AS Unit_Amount, t.$19 AS Extended_Amount, t.$20 AS Place_of_Service, t.$21 AS Facility_Code, t.$22 AS Type_of_Service, t.$23 AS Modifier1, t.$24 AS Modifier2, t.$25 AS Modifier3, t.$26 AS Diagnostic_Reference1, t.$27 AS Diagnostic_Reference2, t.$28 AS Diagnostic_Reference3, t.$29 AS Diagnostic_Reference4, t.$30 AS Remark_20, t.$31 AS Accept_Assignment_Blank, t.$32 AS Approved_Amount10_2, t.$33 AS Balance10_2, t.$34 AS Patient_Charge, t.$35 AS Plan_Charge, t.$36 AS Billto_At_Post, t.$37 AS Plan_At_Post, t.$38 AS Claim_Status, t.$39 AS Statement_Status, t.$40 AS Claim_Count, t.$41 AS Statement_Count, t.$42 AS Last_Payment_Date, t.$43 AS Last_Adjustment_Date, t.$44 AS Last_BillTo_Date, t.$45 AS Last_Statement_Date, t.$46 AS Last_Claim_Date, t.$47 AS Post_Date, t.$48 AS Bill_Type, t.$49 AS Family_Plan, t.$50 AS Emergency, t.$51 AS Coordination__Benefits, t.$52 AS Journal_Number, t.$53 AS Patient_Balance12_2, t.$54 AS Plan_Balance12_2, t.$55 AS DDL_Charge_Select_NOSV, t.$56 AS Equipment_Tran_Number, t.$57 AS RX_Number, t.$58 AS Reclaim_Status, t.$59 AS Last_Post_Date, t.$60 AS Start_Time, t.$61 AS End_Time, t.$62 AS Time_Unit, t.$63 AS Emergency_Unit, t.$64 AS Physical_Unit, t.$65 AS Posting_Status, t.$66 AS Use_Approved, t.$67 AS Approved_Amount82, t.$68 AS Charge_Adjustment, t.$69 AS Charge_Amount82, t.$70 AS Ppr_Payment_Method, t.$71 AS Payment_Amount82, t.$72 AS Location_Code, t.$73 AS Panel_Code, t.$74 AS Department__Code, t.$75 AS Number_Of_Visit, t.$76 AS Schedule_Number, t.$77 AS Transfer_Number, t.$78 AS Discount_Amount, t.$79 AS Unit_Discounted_Fee, t.$80 AS Discounted_Fee, t.$81 AS Unit_Cost, t.$82 AS Cost, t.$83 AS Unit_Professional_Fee, t.$84 AS Professional_Fee, t.$85 AS Unit_Maximum_Amount, t.$86 AS Maximum_Amount, t.$87 AS Unit_Co_Payment_Charge, t.$88 AS Co_payment__Charge, t.$89 AS Bill_Adjustment_Number, t.$90 AS CB_Secondary_Claim, t.$91 AS CB_Co_Pay_Transfer, t.$92 AS DDL_Charge_Source, t.$93 AS Debit_Bill_Number, t.$94 AS Debit_Bill_Number_Seq, t.$95 AS Transaction_Number, t.$96 AS Unified_Transaction_Num, t.$97 AS CB_Non_Covered_Charges, t.$98 AS Unit_of_Measure, t.$99 AS Number_Of_Days_Hours, t.$100 AS DDL_Bill_Type, t.$101 AS CB_Deleted, t.$102 AS Interface_Bill_Number, t.$103 AS Schedule_Time, t.$104 AS Duration, t.$105 AS Referring_Source_Code, t.$106 AS Last_Payment_Post_Date, t.$107 AS Cert_Tran_Number, t.$108 AS Batch_Number, t.$109 AS Admission_Number, t.$110 AS Bill_Date, t.$111 AS First_Payment_Date, t.$112 AS First_Payment_Post_Date, t.$113 AS Transaction_Service_Date, t.$114 AS Transaction_Post_Date, t.$115 AS First_Tran_Date, t.$116 AS First_Tran_Post_Date, t.$117 AS Max_Tran_Date, t.$118 AS Max_Tran_Post_Date, t.$119 AS Modifier4, t.$120 AS Source_Serial, t.$121 AS Source_Sequence, t.$122 AS NDC_NUmber, t.$123 AS Unit_Price, t.$124 AS NDC_Unit_Measure, t.$125 AS Unit_Quantity, t.$126 AS Prescription_Number, t.$127 AS MDS_Number, t.$128 AS Charge_Source_ID, t.$129 AS DEX_ROW_ID, t.$130 AS SYS_CHANGE_VERSION, t.$131 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$131,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_cv_mdchgtrn.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.cv_mdchgtrn AS WITH curr_v AS (SELECT DB, Patient_Number, Service_Date, Bill_Number, Sequence_Number, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_cv_mdchgtrn GROUP BY DB, Patient_Number, Service_Date, Bill_Number, Sequence_Number) SELECT t.* FROM CostalSyncData.HIST_cv_mdchgtrn t INNER JOIN curr_v v ON t.DB = v.DB AND t.Patient_Number = v.Patient_Number AND t.Service_Date = v.Service_Date AND t.Bill_Number = v.Bill_Number AND t.Sequence_Number = v.Sequence_Number AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

