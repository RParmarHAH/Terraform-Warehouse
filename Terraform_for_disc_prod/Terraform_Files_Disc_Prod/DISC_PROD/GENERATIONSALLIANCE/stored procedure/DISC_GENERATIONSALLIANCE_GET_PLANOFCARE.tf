resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_PLANOFCARE" {
	name ="GET_PLANOFCARE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_PlanofCare 
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
    COPY INTO GENERATIONSALLIANCE.PlanofCare FROM (SELECT t.$1 AS clientID, t.$2 AS planOfCareId, t.$3 AS PatientHIClaimNum, t.$4 AS StartCareDt, t.$5 AS certifiedFrom, t.$6 AS certifiedTo, t.$7 AS DME_Supplies, t.$8 AS SafetyMeasures, t.$9 AS NutritionalReq, t.$10 AS Allergies, t.$11 AS Amputation, t.$12 AS Incontinence, t.$13 AS Contracture, t.$14 AS Hearing, t.$15 AS Paralysis, t.$16 AS Endurance, t.$17 AS Ambulation, t.$18 AS Speech, t.$19 AS LegallyBlind, t.$20 AS Dyspnea, t.$21 AS OtherLimitation, t.$22 AS OtherLimitationDescr, t.$23 AS CompleteBedrest, t.$24 AS BedrestBRP, t.$25 AS UpAsTolerated, t.$26 AS TransferBedChair, t.$27 AS ExercisesPrescribed, t.$28 AS PartialWeightBearing, t.$29 AS IndepedentAtHom, t.$30 AS Crutches, t.$31 AS Cane, t.$32 AS Wheelchair, t.$33 AS Walker, t.$34 AS NoRestrictions, t.$35 AS OtherAtivitiesPermitted, t.$36 AS OtherActiviesPermittedDescr, t.$37 AS Oriented, t.$38 AS Comatose, t.$39 AS Forgetful, t.$40 AS Depressed, t.$41 AS Disoriented, t.$42 AS Lethargic, t.$43 AS Agitated, t.$44 AS OtherMentalStatus, t.$45 AS OtherMentalStatusDescr, t.$46 AS Prognosis, t.$47 AS GoalsDischargePland, t.$48 AS HHAReceivedPOTDt, t.$49 AS Physician, t.$50 AS AttendingPhysician, t.$51 AS PrincipleDiagnosis, t.$52 AS PrincipleDiagnosisDate, t.$53 AS SurgicalProcedure, t.$54 AS SurgicalProcedureDate, t.$55 AS OtherDiagnosis1, t.$56 AS OtherDiagnosisDate1, t.$57 AS OtherDiagnosis2, t.$58 AS OtherDiagnosisDate2, t.$59 AS OtherDiagnosis3, t.$60 AS OtherDiagnosisDate3, t.$61 AS assessedBy, t.$62 AS assessedDate, t.$63 AS assessmentRevisedBy, t.$64 AS revisedDate, t.$65 AS assistAmbulation, t.$66 AS assistTransfers, t.$67 AS bedChairOnly, t.$68 AS ROMexersizes, t.$69 AS otherMobility, t.$70 AS reye, t.$71 AS leye, t.$72 AS peripheralOnly, t.$73 AS wearsGlasses, t.$74 AS cleanGlasses, t.$75 AS hardOfHearing, t.$76 AS wearsHearingAid, t.$77 AS isDeaf, t.$78 AS dietNormal, t.$79 AS isDiabetic, t.$80 AS dietLowSodium, t.$81 AS dietLiquidOnly, t.$82 AS assistWithMeals, t.$83 AS assistWithMealsDescr, t.$84 AS feedingAssistance, t.$85 AS feedingInstructions, t.$86 AS bathingPartial, t.$87 AS bathingComplete, t.$88 AS bathingTub, t.$89 AS bathingShower, t.$90 AS bathingSpongeBath, t.$91 AS BathingSink, t.$92 AS bathingOther, t.$93 AS skinMoisturizer, t.$94 AS skinPowder, t.$95 AS skinOther, t.$96 AS washDryHair, t.$97 AS washAndSet, t.$98 AS combAndBrush, t.$99 AS brushAndFloss, t.$100 AS dentureCare, t.$101 AS shaveFace, t.$102 AS shaveAxilla, t.$103 AS shaveLegs, t.$104 AS electricRazor, t.$105 AS safetyRazor, t.$106 AS cleanNails, t.$107 AS fileTrimNails, t.$108 AS polishNails, t.$109 AS selfDress, t.$110 AS helpSelectClothes, t.$111 AS assistWithDressing, t.$112 AS toiletBathroom, t.$113 AS toiletBedpan, t.$114 AS toiletUrinal, t.$115 AS BedSideCommode, t.$116 AS weighClient, t.$117 AS weighFrequency, t.$118 AS drivesSelf, t.$119 AS cargiverMayTakeout, t.$120 AS callBeforeTakingOut, t.$121 AS WaiverOfLiabOnfile, t.$122 AS accompanyOnTaxiBus, t.$123 AS OutdoorRecreation, t.$124 AS guidelines, t.$125 AS HousekepingType, t.$126 AS housekeepingInstructions, t.$127 AS printMedsOnPlanOfCare, t.$128 AS specialInstruction, t.$129 AS HCFA487, t.$130 AS PrincipleDiagnosisDescr, t.$131 AS SurgicalProcedureDescr, t.$132 AS OtherDiagnosis1Descr, t.$133 AS OtherDiagnosis2Descr, t.$134 AS OtherDiagnosis3Descr, t.$135 AS createdBy, t.$136 AS created, t.$137 AS updatedBy, t.$138 AS lastUpdated, t.$139 AS TreatmentFirst, t.$140 AS TreatmentSecond, t.$141 AS IncludeTask, t.$142 AS toiletDepends, t.$143 AS Alzheimers, t.$144 AS Dementia, t.$145 AS SignatureDate, t.$146 AS SignatureName, t.$147 AS SignatureData, t.$148 AS IncludeLimitation, t.$149 AS IncludeDSNA, t.$150 AS attachment, t.$151 AS filename, t.$152 AS IsAttachmentType, t.$153 AS IsTaskRequired, t.$154 AS POCName, t.$155 AS CarePlanTemplateID, t.$156 AS status, t.$157 AS SYS_CHANGE_VERSION, t.$158 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$158,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_PlanofCare.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.PlanofCare AS WITH curr_v AS (SELECT clientID, planOfCareId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.PlanofCare GROUP BY clientID, planOfCareId) SELECT t.* FROM GENERATIONSALLIANCE.PlanofCare t INNER JOIN curr_v v ON t.clientID = v.clientID AND t.planOfCareId = v.planOfCareId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

