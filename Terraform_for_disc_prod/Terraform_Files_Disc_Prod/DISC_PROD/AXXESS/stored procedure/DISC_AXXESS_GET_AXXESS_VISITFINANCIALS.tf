resource "snowflake_procedure" "DISC_AXXESS_GET_AXXESS_VISITFINANCIALS" {
	name ="GET_AXXESS_VISITFINANCIALS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.AXXESS.GET_AXXESS_VisitFinancials 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_VisitFinancials (SELECT DISTINCT * FROM (SELECT A.$1 AS Account_Id,  A.$2 AS Account_Name,  A.$3 AS Branch_Id,  A.$4 AS Branch_Name,  A.$5 AS Scheduled_Task_Id,  A.$6 AS Client_Id,  A.$7 AS Client_First_Name,  A.$8 AS Client_Last_Name,  A.$9 AS Client_Middle_Initial,  A.$10 AS MRN,  A.$11 AS Scheduled_Task_Status,  A.$12 AS Scheduled_Discipline_Task,  A.$13 AS Scheduled_Task_Name,  A.$14 AS Scheduled_Task_Discipline,  A.$15 AS Event_StartTime,  A.$16 AS Event_EndTime,  A.$17 AS Visit_Start,  A.$18 AS Visit_End,  A.$19 AS Scheduled_Task_StartDate,  A.$20 AS Scheduled_Task_EndDate,  A.$21 AS IsPayable_Visit,  A.$22 AS IsBillable_Visit,  A.$23 AS Scheduled_Task_IsOrder,  A.$24 AS Scheduled_Units,  A.$25 AS Scheduled_Task_IsVisitPaid,  A.$26 AS Scheduled_Task_IsAllDay,  A.$27 AS Scheduled_Task_IsMissedVisit,  A.$28 AS Scheduled_Task_IsCarePeriod_Discharged,  A.$29 AS Scheduled_Task_IsCarePeriod_Active,  A.$30 AS Scheduled_Task_IsDeprecated,  A.$31 AS Authorization_Id,  A.$32 AS Authorization_Start,  A.$33 AS Authorization_End,  A.$34 AS Authorization_Number,  A.$35 AS Authorized_Units,  A.$36 AS Available_Units,  A.$37 AS Authorized_Unit_Type,  A.$38 AS Authorized_Frequency_Of_Units,  A.$39 AS Authorized_Occurrence_Frequency,  A.$40 AS Days_Auth_RestrictedTo,  A.$41 AS Authorized_Total_lUnits,  A.$42 AS Authorized_Discipline,  A.$43 AS Authorized_Comments,  A.$44 AS Authorized_Status,  A.$45 AS Authorized_IsDeprecated,  A.$46 AS Claim_Id,  A.$47 AS Claim_StartDate,  A.$48 AS Claim_EndDate,  A.$49 AS Billed_Date,  A.$50 AS Payment_Date,  A.$51 AS Claim_Status,  A.$52 AS Claim_Amount,  A.$53 AS Claim_Invoice_Number,  A.$54 AS Cash_Received,  A.$55 AS Adjustment_Amount,  A.$56 AS Negative_Adjustment_Amount,  A.$57 AS Net_Receivable,  A.$58 AS Account_IsDeprecated,  A.$59 AS Branch_State_Code,  A.$60 AS Branch_Zip_Code,  A.$61 AS Branch_Zip_Code_Four,  A.$62 AS Branch_IsMain_Office,  A.$63 AS Branch_IsDeprecated,  A.$64 AS Primary_Insurance_Id,  A.$65 AS Insurance_Name,  A.$66 AS Payor_Type,  A.$67 AS Payor_Name,  A.$68 AS Payor_Id,  A.$69 AS Client_Address1,  A.$70 AS Client_Address2,  A.$71 AS Client_City,  A.$72 AS Client_State,  A.$73 AS Client_Zip,  A.$74 AS Client_Referral_Source,  A.$75 AS Client_Status,  A.$76 AS Client_Dob,  A.$77 AS Client_Age,  A.$78 AS Client_Medicaid_Number,  A.$79 AS Client_IsHospitalized,  A.$80 AS Client_IsNonMedical,  A.$81 AS Client_Gender,  A.$82 AS Client_DischargeDate,  A.$83 AS Client_DiagnosisId,  A.$84 AS CarePeriod_Id,  A.$85 AS CarePeriod_Start,  A.$86 AS CarePeriod_End,  A.$87 AS CarePeriod_StartOfCare_Date,  A.$88 AS CarePeriod_CaseManager_Id,  A.$89 AS CarePeriod_CaseManager_Name,  A.$90 AS CarePeriod_Comments,  A.$91 AS CarePeriod_IsActive,  A.$92 AS CarePeriod_IsDischarged,  A.$93 AS CarePeriod_IsLinkedToDischarge,  A.$94 AS Admission_Id,  A.$95 AS Admission_Source,  A.$96 AS Admission_Discharge_Date,  A.$97 AS Admission_Discharge_Reason,  A.$98 AS Admission_IsDeprecated,  A.$99 AS Admission_IsNonMedical,  A.$100 AS Admission_ReferralId,  A.$101 AS Admission_StartOfCare_Date,  A.$102 AS IsVerified_Visit,  A.$103 AS Admission_Discharge_Comments,  A.$104 AS Admission_Status,  A.$105 AS Actual_Scheduled_Units,  A.$106 AS Days_Auth_Restricted,  A.$107 AS Clinician_Id,  A.$108 AS Clinician_Name,  A.$109 AS Client_IsDeprecated ,:TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/VisitFinancials(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A));

    return ''Success'';
END;

 EOT
}

