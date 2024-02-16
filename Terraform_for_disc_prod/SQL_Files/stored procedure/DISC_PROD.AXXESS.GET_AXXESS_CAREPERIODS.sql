CREATE OR REPLACE PROCEDURE DISC_PROD.AXXESS.GET_AXXESS_CAREPERIODS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AXXESS.GET_AXXESS_CarePeriods 
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
    INSERT OVERWRITE INTO DISC_PROD.AXXESS.AXXESS_CarePeriods (SELECT DISTINCT * FROM (SELECT A.$1 AS CarePeriod_Id,  A.$2 AS Agency_Id,  A.$3 AS Branch_Id,  A.$4 AS Client_Id,  A.$5 AS Admission_Id,  A.$6 AS Branch_Name,  A.$7 AS Account,  A.$8 AS Referral_Id,  A.$9 AS Referral_Status,  A.$10 AS MRN,  A.$11 AS Client_First_Name,  A.$12 AS Client_Last_Name,  A.$13 AS Client_Middle_Initial,  A.$14 AS Client_Dob,  A.$15 AS Client_Age,  A.$16 AS Admission_Status,  A.$17 AS Admission_Source,  A.$18 AS Branch_IsMain_Office,  A.$19 AS Branch_State_Code,  A.$20 AS Branch_Zip_Code,  A.$21 AS Branch_Zip_Code_Four,  A.$22 AS LengthOfStay,  A.$23 AS Admission_Discharge_Date,  A.$24 AS Admission_Discharge_Reason,  A.$25 AS Admission_IsNonMedical,  A.$26 AS Admission_StartOfCare_Date,  A.$27 AS CarePeriod_CaseManager_Id,  A.$28 AS CarePeriod_CaseManager_Name,  A.$29 AS CarePeriod_End_Date,  A.$30 AS CarePeriod_Start_Date,  A.$31 AS CarePeriod_StartOfCare_Date,  A.$32 AS Client_Address1,  A.$33 AS Client_Address2,  A.$34 AS Client_City,  A.$35 AS Client_Discharge_Date,  A.$36 AS Client_Gender,  A.$37 AS Client_IsHospitalized,  A.$38 AS Client_IsNonMedical,  A.$39 AS Client_Medicaid_Number,  A.$40 AS Client_Referral_Source,  A.$41 AS Client_State,  A.$42 AS Client_Status,  A.$43 AS Client_Zip,  A.$44 AS Diagnosis_Id,  A.$45 AS Diagnosis_Code,  A.$46 AS Diagnosis_Date,  A.$47 AS Diagnosis_Icd10_Code,  A.$48 AS Diagnosis_Icd10_Name,  A.$49 AS Diagnosis_Name,  A.$50 AS Diagnosis_Type,  A.$51 AS Insurance_Id,  A.$52 AS Insurance_Name,  A.$53 AS IsAdmit,  A.$54 AS IsDirectAdmission,  A.$55 AS IsDischarged,  A.$56 AS IsReferral,  A.$57 AS Payor_Id,  A.$58 AS Payor_Name,  A.$59 AS Payor_Type,  A.$60 AS Physician_Id,  A.$61 AS Physician_First_Name,  A.$62 AS Physician_Last_Name,  A.$63 AS Physician_Middle_Name,  A.$64 AS Physician_Address1,  A.$65 AS Physician_Address2,  A.$66 AS Physician_City,  A.$67 AS Physician_Gender,  A.$68 AS Physician_NPI,  A.$69 AS Physician_State_Code,  A.$70 AS Physician_Zip_Code,  A.$71 AS Referral_First_Name,  A.$72 AS Referral_Last_Name,  A.$73 AS Referral_Middle_Initial,  A.$74 AS Referral_Date,  A.$75 AS Referral_Dob,  A.$76 AS Referral_Gender,  A.$77 AS Referral_IsNonMedical,  A.$78 AS Referral_Medicaid_Number,  A.$79 AS Referral_Requested_StartOfCare_Date,  A.$80 AS Referral_Source_Name,  A.$81 AS Referral_Source_Type,  A.$82 AS Hospital_AdmitDate,  A.$83 AS IsHospitalized,  A.$84 AS Admission_nDischarge_Comments,  A.$85 AS IsClient_Deprecated ,  A.$86 AS Client_Ethnicities ,  A.$87 AS Client_Races ,:TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/CarePeriods(file_format => DISC_PROD.STAGE.PSV_FORMAT) A));

    return ''Success'';
END;
';