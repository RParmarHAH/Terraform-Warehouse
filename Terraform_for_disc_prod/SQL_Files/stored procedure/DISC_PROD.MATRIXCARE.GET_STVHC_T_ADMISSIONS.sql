CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_ADMISSIONS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_Admissions 
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
    COPY INTO MatrixCare.HIST_STVHC_T_Admissions FROM (SELECT t.$1 AS adm_ID, t.$2 AS adm_BranchID, t.$3 AS adm_ClientID, t.$4 AS adm_MedicalRecordNumber, t.$5 AS adm_ReferralDate, t.$6 AS adm_ReferralTakenBy, t.$7 AS adm_ReferralTypeID, t.$8 AS adm_NonAdmissionReasonID, t.$9 AS adm_StatusID, t.$10 AS adm_InternalCaseMgrID, t.$11 AS adm_VerbalSOCDate, t.$12 AS adm_VerbalSOCTakenBy, t.$13 AS adm_SourceID, t.$14 AS adm_ActualSOCDate, t.$15 AS adm_PrimaryDiagnosis, t.$16 AS adm_DiagnosisNotes, t.$17 AS adm_ExcludeBillingFlag, t.$18 AS adm_DischargeDate, t.$19 AS adm_DischargeReasonID, t.$20 AS adm_DischargeRecordedDate, t.$21 AS adm_LastServiceDate, t.$22 AS adm_DischargeSummaryReason, t.$23 AS adm_DischargeSummaryEvaluationOfGoals, t.$24 AS adm_DischargeSummaryConditionOfClient, t.$25 AS adm_DischargeSummaryDispositionOfClient, t.$26 AS adm_OtherDischargeNotes_InternalUse, t.$27 AS adm_CreatedDate, t.$28 AS adm_CreatedUser, t.$29 AS adm_ModifiedDate, t.$30 AS adm_ModifiedUser, t.$31 AS adm_TS, t.$32 AS adm_NonAdmitDate, t.$33 AS adm_HHASpecialInstructions, t.$34 AS adm_HHAActivities, t.$35 AS adm_HHAOtherInstructions, t.$36 AS adm_RelInfo, t.$37 AS adm_AssignBenefits, t.$38 AS adm_ReferralEntityTypeID, t.$39 AS adm_ReferralEntityID, t.$40 AS adm_ReferralContactJoinID, t.$41 AS adm_StaffID, t.$42 AS adm_OasisPhysicianID, t.$43 AS adm_ReferralNotes, t.$44 AS adm_ReferralCampaignID, t.$45 AS adm_AdmissionsDispositionReasonsID_NAR, t.$46 AS adm_NonAdmitNotes, t.$47 AS adm_AdmissionsDispositionReasonsID_DChg, t.$48 AS adm_ReferralTakenByID, t.$49 AS adm_CAHPSParticipationDeclined, t.$50 AS adm_CAHPSReceivingHospice, t.$51 AS adm_CAHPSReceivingPediatric, t.$52 AS adm_CAHPSReceivingMaternity, t.$53 AS adm_F2FEncounter, t.$54 AS adm_ReceivingInsulinInjectionServices, t.$55 AS adm_ReceivingHospiceServices, t.$56 AS adm_ReceivingInsulinServicesNotes, t.$57 AS adm_ReceivingHospiceServicesNotes, t.$58 AS adm_CertPhysicianID, t.$59 AS adm_SupervisorID, t.$60 AS adm_CoordinatorID, t.$61 AS adm_Features, t.$62 AS InsertDate, t.$63 AS UpdateDate, t.$64 AS DeletedFlag, t.$65 AS SYS_CHANGE_VERSION, CASE WHEN t.$64 = True THEN ''D'' WHEN t.$62 = t.$63 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$64, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_Admissions.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_Admissions AS WITH curr_v AS (SELECT adm_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_Admissions GROUP BY adm_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT ADM_BRANCHID FROM MatrixCare.HIST_STVHC_T_ADMISSIONS br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.ADM_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_Admissions t INNER JOIN curr_v v ON t.adm_ID = v.adm_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.ADM_BRANCHID NOT IN (SELECT ADM_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';