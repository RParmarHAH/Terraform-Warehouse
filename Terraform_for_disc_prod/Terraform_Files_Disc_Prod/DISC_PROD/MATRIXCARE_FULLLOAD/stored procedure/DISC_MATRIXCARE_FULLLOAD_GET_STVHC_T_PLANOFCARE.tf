resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_PLANOFCARE" {
	name ="GET_STVHC_T_PLANOFCARE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_PlanOfCare 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PlanofCare FROM (SELECT t.$1 AS poc_ID, t.$2 AS poc_AdmissionID, t.$3 AS poc_CertStartDate, t.$4 AS poc_CertEndDate, t.$5 AS poc_MSAID, t.$6 AS poc_CBSAID, t.$7 AS poc_HHRGID, t.$8 AS poc_HIPPSID, t.$9 AS poc_PPSSupplyCode, t.$10 AS poc_PPSSuppliesProvided, t.$11 AS poc_PPSSuppliesProvidedModifiedUser, t.$12 AS poc_PPSSuppliesProvidedModifiedDate, t.$13 AS poc_IntakeBy, t.$14 AS poc_GivenBy, t.$15 AS poc_Notes, t.$16 AS poc_TreatmentAuthorization, t.$17 AS poc_Alergies, t.$18 AS poc_MentalStatusOriented, t.$19 AS poc_MentalStatusForgetful, t.$20 AS poc_MentalStatusDisoriented, t.$21 AS poc_MentalStatusAgitated, t.$22 AS poc_MentalStatusComatose, t.$23 AS poc_MentalStatusDepressed, t.$24 AS poc_MentalStatusLethargic, t.$25 AS poc_MentalStatusOther, t.$26 AS poc_MentalStatusOtherDesc, t.$27 AS poc_PrognosisPoor, t.$28 AS poc_PrognosisGuarded, t.$29 AS poc_PrognosisFair, t.$30 AS poc_PrognosisGood, t.$31 AS poc_PrognosisExellent, t.$32 AS poc_AssistDevices, t.$33 AS poc_DMESupplies, t.$34 AS poc_SafetyMeasures, t.$35 AS poc_NutritionalRequirements, t.$36 AS poc_FunctionalLimitationAmputation, t.$37 AS poc_FunctionalLimitationBowelBaldder, t.$38 AS poc_FunctionalLimitationContracture, t.$39 AS poc_FunctionalLimitationHearing, t.$40 AS poc_FunctionalLimitationParalysis, t.$41 AS poc_FunctionalLimitationEndurance, t.$42 AS poc_FunctionalLimitationAmbulation, t.$43 AS poc_FunctionalLimitationSpeech, t.$44 AS poc_FunctionalLimitationVision, t.$45 AS poc_FunctionalLimitationDyspnea, t.$46 AS poc_FunctionalLimitationOther, t.$47 AS poc_FunctionalLimitationOtherDesc, t.$48 AS poc_ActivitiesPermittedCompleteBedrest, t.$49 AS poc_ActivitiesPermittedBedrestBRP, t.$50 AS poc_ActivitiesPermittedUpAsTolerated, t.$51 AS poc_ActivitiesPermittedTransferBedToChair, t.$52 AS poc_ActivitiesPermittedIndependentAtHome, t.$53 AS poc_ActivitiesPermittedPartialWeightBearing, t.$54 AS poc_ActivitiesPermittedCrutches, t.$55 AS poc_ActivitiesPermittedCane, t.$56 AS poc_ActivitiesPermittedWheelchair, t.$57 AS poc_ActivitiesPermittedWalker, t.$58 AS poc_ActivitiesPermittedNoRestrictions, t.$59 AS poc_ActivitiesPermittedExercisePrescribed, t.$60 AS poc_ActivitiesPermittedOther, t.$61 AS poc_ActivitiesPermittedOtherDesc, t.$62 AS poc_HHASpecialInstructions, t.$63 AS poc_HHAActivities, t.$64 AS poc_HHAOtherInstructions, t.$65 AS poc_Diagnosis, t.$66 AS poc_DiagnosisNotes, t.$67 AS poc_PharmacyName, t.$68 AS poc_PharmacyPhone, t.$69 AS poc_PharmacyFax, t.$70 AS poc_OasisLockDate, t.$71 AS poc_BillingProcessID, t.$72 AS poc_BillingStatusID, t.$73 AS poc_BillingFirstVisitScheduleID, t.$74 AS poc_Goals, t.$75 AS poc_RehabilitationPotenial, t.$76 AS poc_DischargePlans, t.$77 AS poc_PhysicianID, t.$78 AS poc_CarePlanTrackingDueDate, t.$79 AS poc_CarePlanTrackingSentDate, t.$80 AS poc_CarePlanTrackingSecondSentDate, t.$81 AS poc_CarePlanTrackingDateReceived, t.$82 AS poc_CarePlanTrackingNotes, t.$83 AS poc_OasisInterfaceID, t.$84 AS poc_CreatedDate, t.$85 AS poc_CreatedUser, t.$86 AS poc_ModifiedDate, t.$87 AS poc_ModifiedUser, t.$88 AS poc_TS, t.$89 AS poc_Height, t.$90 AS poc_Weight, t.$91 AS poc_485ProcessID, t.$92 AS poc_485StatusID, t.$93 AS poc_485AssessmentHistoryID, t.$94 AS poc_VerbalStartOfCareDate, t.$95 AS poc_485DiagnosisVersion, t.$96 AS poc_PreClaimReviewUTN, t.$97 AS poc_ServicePlanHeaderDraftID, t.$98 AS poc_ServicePlanHeaderFinalizedID, t.$99 AS poc_Features, t.$100 AS poc_HHAQualifyingTasks, t.$101 AS poc_HHAPayerRequirementsNotes, t.$102 AS poc_AdvancedDirectives, t.$103 AS poc_AdvancedDirectivesOther, t.$104 AS poc_HospitalRiskFactor, t.$105 AS poc_CognitivePsychosocialStatus, t.$106 AS poc_CognitivePsychosocialStatusOther, t.$107 AS InsertDate, t.$108 AS UpdateDate, t.$109 AS DeletedFlag, t.$110 AS SYS_CHANGE_VERSION, CASE WHEN t.$109 = True THEN ''D'' WHEN t.$107 = t.$108 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$109, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PlanofCare[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PlanofCare AS WITH curr_v AS (SELECT poc_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PlanofCare GROUP BY poc_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_PlanofCare t INNER JOIN curr_v v ON t.poc_ID = v.poc_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

