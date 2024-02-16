resource "snowflake_procedure" "DISC_AXXESS_GET_AXXESS_PATIENTVISITS" {
	name ="GET_AXXESS_PATIENTVISITS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.AXXESS.GET_AXXESS_PATIENTVISITS 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_PATIENTVISITS (SELECT A.$1 AS Visit_Id, A.$2 AS Branch_Id, A.$3 AS Episode_Id, A.$4 AS Patient_Id, A.$5 AS Account, A.$6 AS Branch, A.$7 AS Payor_Type, A.$8 AS Payor_Class, A.$9 AS Episode_Primary_Insurance, A.$10 AS Current_Primary_Insurance, A.$11 AS Start_Of_Care_Date, A.$12 AS Episode_Start_Date, A.$13 AS Episode_End_Date, A.$14 AS Episode_Discharge_Date, A.$15 AS Mrn, A.$16 AS Patient_First_Name, A.$17 AS Patient_Last_Name, A.$18 AS Patient_Status, A.$19 AS Admission_Status, A.$20 AS Date_Of_Birth, A.$21 AS Patient_Age, A.$22 AS City, A.$23 AS County, A.$24 AS State, A.$25 AS Zip_Code, A.$26 AS Visit_Name, A.$27 AS Visit_Type, A.$28 AS Visit_Status, A.$29 AS Visit_Date, A.$30 AS Visit_Time_In, A.$31 AS Visit_Time_Out, A.$32 AS Schedule_Date, A.$33 AS Clinician_Name, A.$34 AS Is_Missed_Visit, A.$35 AS AddressLine_1, A.$36 AS AddressLine_2, A.$37 AS Is_Order_For_Next_Episode, A.$38 AS Is_Visit_Authorization_Required, A.$39 AS Is_Visit_Authorized, A.$40 AS Order_Number, A.$41 AS Order_Episode_Id, A.$42 AS Order_Certification_Start_Date, A.$43 AS Order_Certification_End_Date, A.$44 AS Order_Md_Signature_Date, A.$45 AS Order_Physician, A.$46 AS Order_Received_By, A.$47 AS Order_Received_Date, A.$48 AS Order_Sent_Date, A.$49 AS Order_Type, A.$50 AS Fact_AR_Id, A.$51 AS ISBILLABLE,A.$52 AS IS_COMPLETED_VISIT, A.$53 AS CASE_MANAGER_ID, A.$54 AS CLINICIAN_ID, A.$55 AS INSURANCE_FEE_SCHEDULE_ID, A.$56 AS INSURANCE_ID, A.$57 AS PAYER_ID, :TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/PatientVisits(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A);

    return ''Success'';
END;

 EOT
}

