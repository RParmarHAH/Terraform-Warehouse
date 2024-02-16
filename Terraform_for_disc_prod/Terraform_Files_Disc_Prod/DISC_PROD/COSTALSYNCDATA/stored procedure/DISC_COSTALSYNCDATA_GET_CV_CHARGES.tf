resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_CHARGES" {
	name ="GET_CV_CHARGES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_CV_Charges 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_CV_Charges FROM (SELECT t.$1 AS Db, t.$2 AS Entry_Date, t.$3 AS Update_Date, t.$4 AS Patient_Number, t.$5 AS Service_Date, t.$6 AS Bill_Number, t.$7 AS Sequence_Number, t.$8 AS Service_Thru_Date, t.$9 AS Provider_Code, t.$10 AS Billto_Status_Code, t.$11 AS Plan_Code, t.$12 AS ProcCode, t.$13 AS Number_Of_Unit, t.$14 AS Unit_Amount, t.$15 AS Extended_Amount, t.$16 AS Place_of_Service, t.$17 AS Facility_Code, t.$18 AS Type_of_Service, t.$19 AS Modifier1, t.$20 AS Modifier2, t.$21 AS Modifier3, t.$22 AS Diagnostic_Reference1, t.$23 AS Diagnostic_Reference2, t.$24 AS Diagnostic_Reference3, t.$25 AS Diagnostic_Reference4, t.$26 AS Remark_20, t.$27 AS Accept_Assignment_Blank, t.$28 AS Approved_Amount10_2, t.$29 AS Balance10_2, t.$30 AS Patient_Charge, t.$31 AS Plan_Charge, t.$32 AS Billto_At_Post, t.$33 AS Plan_At_Post, t.$34 AS Claim_Status, t.$35 AS Statement_Status, t.$36 AS Claim_Count, t.$37 AS Statement_Count, t.$38 AS Last_Payment_Date, t.$39 AS Last_Adjustment_Date, t.$40 AS Last_BillTo_Date, t.$41 AS Last_Statement_Date, t.$42 AS Last_Claim_Date, t.$43 AS Post_Date, t.$44 AS Bill_Type, t.$45 AS Journal_Number, t.$46 AS DDL_Charge_Select_NOSV, t.$47 AS Last_Post_Date, t.$48 AS Use_Approved, t.$49 AS Approved_Amount82, t.$50 AS Charge_Amount82, t.$51 AS Ppr_Payment_Method, t.$52 AS Payment_Amount82, t.$53 AS Location_Code, t.$54 AS Panel_Code, t.$55 AS Department__Code, t.$56 AS Schedule_Number, t.$57 AS Transfer_Number, t.$58 AS Bill_Adjustment_Number, t.$59 AS DDL_Charge_Source, t.$60 AS Number_Of_Days_Hours, t.$61 AS DDL_Bill_Type, t.$62 AS Interface_Bill_Number, t.$63 AS Schedule_Time, t.$64 AS Duration, t.$65 AS Referring_Source_Code, t.$66 AS Last_Payment_Post_Date, t.$67 AS Cert_Tran_Number, t.$68 AS Batch_Number, t.$69 AS Admission_Number, t.$70 AS Bill_Date, t.$71 AS Transaction_Service_Date, t.$72 AS Transaction_Post_Date, t.$73 AS First_Tran_Date, t.$74 AS First_Tran_Post_Date, t.$75 AS Max_Tran_Date, t.$76 AS Max_Tran_Post_Date, t.$77 AS Modifier4, t.$78 AS Charge_Source_ID, t.$79 AS DEX_ROW_ID, t.$80 AS SYS_CHANGE_VERSION, t.$81 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$81,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_Charges.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_Charges AS WITH curr_v AS (SELECT Db, Patient_Number, Service_Date, Bill_Number, Sequence_Number, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_Charges GROUP BY Db, Patient_Number, Service_Date, Bill_Number, Sequence_Number) SELECT t.* FROM CostalSyncData.HIST_CV_Charges t INNER JOIN curr_v v ON t.Db = v.Db AND t.Patient_Number = v.Patient_Number AND t.Service_Date = v.Service_Date AND t.Bill_Number = v.Bill_Number AND t.Sequence_Number = v.Sequence_Number AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

