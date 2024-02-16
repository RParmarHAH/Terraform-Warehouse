resource "snowflake_procedure" "DISC_AXXESS_GET_AXXESS_ARS" {
	name ="GET_AXXESS_ARS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.AXXESS.GET_AXXESS_ARS 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_ARS (SELECT A.$1 AS Id, A.$2 AS Branch_Id, A.$3 AS Patient_Id, A.$4 AS Episode_Id, A.$5 AS Account, A.$6 AS Branch, A.$7 AS Patient_First_Name, A.$8 AS Patient_Last_Name, A.$9 AS Mrn, A.$10 AS Patient_Status, A.$11 AS Primary_Insurance_Name, A.$12 AS Assessment_Type, A.$13 AS Claim_Start_Date, A.$14 AS Claim_End_Date, A.$15 AS Cash_Received, A.$16 AS Rap_Bill_Date, A.$17 AS Is_First_Billable_Visit, A.$18 AS Payor_Class, A.$19 AS Payor_Type, A.$20 AS Original_Hipps_Revenue, A.$21 AS Patient_Full_Name, A.$22 AS Adjusted_Revenue, A.$23 AS Final_Or_ManagedCare_Bill_Date, A.$24 AS Final_Or_ManagedCare_Status, A.$25 AS Gross_Ar, A.$26 AS Net_Adjustments, A.$27 AS Net_Receivable, A.$28 AS Rap_Status, A.$29 AS Final_Or_ManagedCare_Amount, A.$30 AS Rap_Amount, A.$31 AS Episode_End_Date, A.$32 AS Episode_Start_Date, A.$33 AS Is_SOE, A.$34 AS Admission_Status, A.$35 AS Billing_Period_Type, A.$36 AS Final_Claim_Payment_Date, A.$37 AS Managed_Claim_Payment_Date, A.$38 AS Rap_Claim_Payment_Date, A.$39 AS Final_Claim_Cash_Received, A.$40 AS Rap_Cash_Received, A.$41 AS Physician_Name, A.$42 AS INSURANCE_ID,:TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/ARs(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A);

    return ''Success'';
END;

 EOT
}

