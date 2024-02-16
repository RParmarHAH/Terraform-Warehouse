resource "snowflake_table" "DISC_RISKONNECT_HIST_HC_AMBULATORY_EVENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "RISKONNECT"
	name = "HIST_HC_AMBULATORY_EVENT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.RISKONNECT.HIST_HC_AMBULATORY_EVENT

    -- Purpose : Discovery Data Population

    -- Project : RISKONNECT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OWNERID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RECORDTYPEID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTACTIVITYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CONNECTIONRECEIVEDID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONNECTIONSENTID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADR_REACTION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADT_EVENT_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AHRQ_HARM_SCALE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACTION_TAKEN_TO_RESOLVE_EVENT__C"
	type = "VARCHAR(550)"
	nullable = true
}


column {
	name = "ACTIONS_TAKEN_TO_PREVENT_RE_OCCURRENCE__C"
	type = "VARCHAR(550)"
	nullable = true
}


column {
	name = "ACTUAL_ROUTE_OF_ADMINISTRATION__C"
	type = "VARCHAR(550)"
	nullable = true
}


column {
	name = "ADDITIONAL_EVENT_DETAILS__C"
	type = "VARCHAR(16777215)"
	nullable = true
}


column {
	name = "ADMIT_VISIT_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "ADMITTING_DIAGNOSIS__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADVERSE_OUTCOME__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ALTERED_SENSATION__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "AMBULATORY_EVENT_STATUS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ANESTHESIA_SEDATION_UTILIZED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ANONYMOUS_REPORTER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ANTICIPATED_HARM_DURATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ANTIDOTE_UTILIZED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ASSOCIATED_WITH_HANDOFF__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BEHAVIOR_DISCUSSED_WITH_PATIENT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BEHAVIOR_ISSUE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BLISTERING_ULCERATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BLOOD_PRODUCT_EVENT_CATEGORY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BLOOD_STAGE_DISCOVER_OTHER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BLOOD_STAGE_EVENT_ORIGINATED_OTHER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BODY_PART__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BRAND_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLAIM__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COMPOUND_PREPERATION_INGREDIENTS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONSENT_DOCUMENT_ISSUE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONVERTED_TO_CLAIM__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CONVERTED_TO_PATIENT_FEEDBACK__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COUNT_PERFORMED_FOR_OBJECT_RETAINED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DATE_EVENT_CLOSED__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_PROVIDER_NOTIFIED__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_REOPENED__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_OF_ADR__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_OF_EVENT__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_OF_FALL_RISK_ASSESSMENT__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DECREASED_PERFUSION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DEVICE_REMOVED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSTIC_ISSUE_FOR_LAB__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DIAGNOSTIC_RADIOLOGY_ISSUE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DID_EVENT_INVOLVE_TEMPATURE_EXCURSION__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DO_NOT_SUBMIT_TO_PSO__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DOSAGE_FORM__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DOSAGE_OF_DRUG__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DRUG_CLASSIFICATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DRUG_GIVEN_TO_TREAT_ADR__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DRUG_MANUFACTURER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DURING_WHAT_STAGE_WAS_EVENT_DISCOVERED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EVENT_DESCRIPTION__C"
	type = "VARCHAR(16777215)"
	nullable = true
}


column {
	name = "EVENT_DISCOVERY_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "EVENT_DISCOVERY_TIME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EVENT_DOCUMENTED_IN_MR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EVENT_PROCEDURE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FALL_RISK_ASSESSMENT_DOCUMENTED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GENERIC_MEDICATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GENERIC_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HISTORY_OF_ALLERGIES__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HOSPITALIZED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HOW_PREVENTABLE_WAS_EVENT__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "IM_STATUS__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INCORRECT_ACTION_INVOLVED__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INCORRECT_DOSE_S__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INCORRECT_RATE__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INCORRECT_STRENGTH_OR_CONCENTRATION__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INCORRECT_TIMING__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INITIAL_INTERVENTIONS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INITIAL_PDF_CREATED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INTENDED_ROUTE_OF_ADMIN__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INTENDED_ROUTE_OF_ADMINISTRATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INTERVENTION_ATTEMPTED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INTERVENTION_DOCUMENTED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LEVEL_OF_SEDATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCATION_OF_CATHETER_CANNULA__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MANUFACTURER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MEASURES_IN_PLACE_TO_PREVENT_FALL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MED_SUB_CONTRAINDICATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MEDICATION_CONTRIBUTED_TO_FALL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MEDICATION_SUBSTANCE_EXPIRATION_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "MEDICATION_SUBSTANCE_INCORRECT_ACTION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MEDICATION_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NQF_REPORTABLE_EVENT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NAME_OF_DEVICE_INFORMATION_SYSTEM__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NAME_OF_PROVIDER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NUTRITION_ISSUE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ON_MEDS_KNOWN_TO_INCREASE_FALL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_ADR_REACTION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_ACTIVITY_PRIOR_TO_FALL__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_ACTUAL_ROUTE_OF_ADMIN__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_ADVERSE_OUTCOME__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_BEHAVIOR_ISSUE__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_BLOOD_PRODUCT_INCORRECT_ACTION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_BLOOD_PRODUCT_INVOLVED__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_DIAGNOSTIC_RADIOLOGY_ISSUE__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_FALL_RISK_FACTORS_PRESENT_AT_FALL__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_INTENDED_ROUTE_OF_ADMIN__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_INTERVENTION_DOCUMENTED__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_LABORATORY_ISSUE__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_LOCATION_OF_CATHETER_CANNULA__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_MEASURES_IN_PLACE_TO_PREVENT_FALL__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_MED_SUB_INCORRECT_ACTION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_PRODUCTS__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_REASON_FOR_HOSP_TRANS_ADMISSION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_RETAINED_OBJECT__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_STAGE_MED_SUB_EVENT_ORIGINATED__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_SUBSTANCE_INVOLVED__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_TEMPATURE_EXCURSION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_TREATMENT_PROCEDURE_ISSUE__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_TYPE_OF_AIRWAY_MANAGEMENT_PROBLEM__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_TYPE_OF_ANESTHESIA_SEDATION_EVENT__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_TYPE_OF_INCORRECT_SURGERY__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_TYPE_OF_INJURY_SUSTAINED__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_TYPE_OF_SEDATION_ISSUE__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHER_TYPE_OF_SURGICAL_EVENT__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PSO_TIME_SUBMISSION__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAIN_LEVEL__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PATIENT_ACCOUNT_NUMBER__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PATIENT_ACTIVITY_PRIOR_TO_FALL__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PATIENT_ADDRESS_1__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_ADDRESS_2__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_BUSINESS_PHONE__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PATIENT_CITY__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PATIENT_CLASS__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PATIENT_DOB__C"
	type = "DATE"
	nullable = true
}


column {
	name = "PATIENT_DOD__C"
	type = "DATE"
	nullable = true
}


column {
	name = "PATIENT_EMAIL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_FEEDBACK__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PATIENT_FIRST_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_GENDER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_HOME_PHONE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_LAST_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_MRN__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_MARITAL_STATUS__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PATIENT_MIDDLE_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_NOTIFIED_OF_EVENT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PATIENT_SSN__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_STATE__C"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PATIENT_SUFFIX__C"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PATIENT_VISIT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_ZIP_CODE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PATIENT_AT_INCREASED_RISK_FOR_FALL__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PATIENT_REFERED_TO_SOCIAL_WORKER__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PATIENT_S_RACE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHASE_OF_LAB_PROCESS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHASE_OF_RADIOLOGY_PROCESS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYSICAL_DEVICE_CONTRBUTE_TO_FALL__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PHYSICAL_INJURY_AS_A_RESULT_OF_THE_FALL__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PRIMARY_FACILITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIMARY_LANGUAGE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIMARY_LOCATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIMARY_MEDICATION_COUNT__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PRIMARY_MEDICATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROVIDER_FIRST_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROVIDER_LAST_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROVIDER_NOTIFIED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RATE_OF_ADMINISTRATION__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RE_SUBMISSION_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "RE_SUBMISSION_FILE_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REASON_FOR_HOSPITAL_TRANSFER_ADMISSION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REASON_FOR_TEMPATURE_EXCURSION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORT_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "REPORTABLE_EVENT_CAUSE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REPORTED_COUNT_STATUS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTER_EMAIL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTER_FIRST_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTER_JOB_OR_POSITION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTER_LAST_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTER_PHONE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RESUBMIT_TO_PSO__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REVIEW_RECORD_S_AUTO_CREATED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REVIEWER_ADDITIONAL_DETAILS__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "REVIWER_COMMENTS__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "RISK_FACTORS_PRESENT_AT_TIME_OF_FALL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SECONDARY_FACILITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SECONDARY_LOCATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SENTINEL_EVENT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SERIAL_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERIOUS_REPORTABLE_EVENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVICE_LINE_AE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SEVERITY_OF_BURN__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SEVERITY_OF_EVENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SHIFT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SKIN_APPEARANCE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STAGE_BLOOD_EVENT_ORIGINATED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STAGE_MED_SUB_EVENT_ORIGINATE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE_REGULATORY_AGENCY_IES_NOTIFIED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STRENGTH__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STRENGTH_OF_DRUG__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SUPERVISION_BY_ANESTHESIOLOGIST__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SURGICAL_ANESTHESIA_EVENT_DISCOVERED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SURGICAL_EVENT_DISCOVERED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SWELLING__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TIME_PROVIDER_NOTIFIED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TIME_OF_EVENT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_AIRWAY_MANAGEMENT_PROBLEM__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_ANESTHESIA_EVENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_ANESTHESIA__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_BLOOD_PRODUCT_INVOLVED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_CONSENT_INVOVLED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_EVENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_INCORRECT_SURGERY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_MEDICATION_SUBSTANCE_INVOLVED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TYPE_OF_OBJECT_RETAINED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_SEDATION_ISSUE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_SURGICAL_EVENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_TREATMENT_PROCEDURE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WAS_DEVICE_IN_THE_PATIENT__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "WAS_ISSUE_DOCUMENTED_IN_THE_EHR__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "WAS_SURGERY_REQUIRED__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "WAS_THE_FALL_OBSERVED__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "WAS_THE_FALL_UNASSISTED_OR_ASSISTED__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "WAS_THE_DRUG_INVOLVED_A_NARCOTIC__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "WERE_SYMPTOMS_RESOLVED__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHAT_DEVICE_WAS_INVOLVED__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHAT_TYPE_OF_BIOLOGICAL_PRODUCTS__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHAT_TYPE_OF_INJURY_WAS_SUSTAINED__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHAT_WAS_THE_VOLUME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHAT_WAS_THE_ADMISSION_EVENT_OTHER__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHAT_WAS_THE_ADMISSION_EVENT__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHAT_WAS_THE_DISCHARGE_EVENT_OTHER__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHAT_WAS_THE_DISCHARGE_EVENT__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHAT_WAS_THE_TRANSFER_EVENT_OTHER__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHAT_WAS_THE_TRANSFER_EVENT__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHEN_WAS_HARM_ASSESSED__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHERE_DID_THE_FALL_OCCUR__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHICH_FIRE_BURN_OCCURRED__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHO_ADMINISTERED_ANESTHESIA__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHO_OBSERVED_THE_FALL__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WITNESS_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "X_RAY_OBTAINED_TO_DETECT_OBJECT__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "AGE_OF_EVENT__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DEPARTMENT_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FACILITY_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "IM_DELETE_FLAG__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NAME_OF_TREATMENT_PROCEDURE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OFFICE_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PATIENT_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PATIENT_S_AGE_AT_EVENT_AHRQ__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PATIENT_S_AGE_AT_EVENT__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENT_S_AGE_AT_EVENT_IN_DAYS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REGION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RISK_MANAGEMENT_REVIEWED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CONVERT_TO_CLAIM__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STAFF_ON_SHIFT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REVIEWED_BY_Q_C__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INTERNAL_NOTES__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "COMPLIANCE_CONCERN__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ALLEGED_THEFT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "POPULATES_DATE_FOR_LETTERS__C"
	type = "DATE"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

