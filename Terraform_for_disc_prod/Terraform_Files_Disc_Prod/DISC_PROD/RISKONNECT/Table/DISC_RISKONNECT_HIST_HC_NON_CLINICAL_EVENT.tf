resource "snowflake_table" "DISC_RISKONNECT_HIST_HC_NON_CLINICAL_EVENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "RISKONNECT"
	name = "HIST_HC_NON_CLINICAL_EVENT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.RISKONNECT.HIST_HC_NON_CLINICAL_EVENT

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
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "OWNERID"
	type = "VARCHAR(25)"
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
	name = "ACTION_TAKEN_TO_RESOLVE_EVENT__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ACTION_TAKEN_AS_A_RESULT_OF_ACCIDENT__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADDITIONAL_EVENT_DETAILS__C"
	type = "VARCHAR(16777215)"
	nullable = true
}


column {
	name = "ADMIN_BILLING_SYSTEM_COMPONENT__C"
	type = "VARCHAR(250)"
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
	name = "AGENCY_INVOLVED__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ANONYMOUS_REPORTER__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ANTICIPATED_HARM_DURATION__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ASSOCIATED_WITH_HANDOFF__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BODY_PART_INJURED__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BODY_PART_AFFECTED_BE_SPECIFIC_PLEASE__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CAUSE_OF_FLOOD__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLAIM__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENT_INJURY__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COMMUNICATION_METHOD__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COMMUNICATION_TIME_FRAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COMPANY_VEHICLE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COMPLETE_PATIENT_FORM__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COMPLIANCE_ITEM_VIOLATED__C"
	type = "VARCHAR(10)"
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
	name = "DATE_REPORTED_TO_REG_GOVT_AGENCY__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_OF_EVENT__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DEPARTMENT_NOTIFIED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DID_FIRE_EMS_RESPOND__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DID_THE_EMERGENCY_GENERATOR_TURN_ON__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DID_YOU_CONTACT_COMMUNICATIONS_DEPT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DISCLOSURE_BILLING_OR_ACCOUNT_ERRORS__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DISCREPANCY_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DO_NOT_SUBMIT_TO_PSO__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EHR_TYPE_OR_COMPONENT_INVOLVED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMS_911_CALLED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EMPLOYEE_IN_VEHICLE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EMPLOYEE_S_PERSON_S_INVOLVED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEES_INVOLVED_IN_ACCIDENT__C"
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
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EVENT_DOCUMENTED_IN_MR__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EVERYONE_EVACUATED_DUE_TO_EVENT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FIRE_DEPARTMENT_SPECIFIC_FINDINGS__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "FIRE_ALARM_ACTIVATE_AUTOMATICALLY__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FIRE_AT_CLIENT_HOME_STAFF_PRESENT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FIRE_DEPT_REPORT_ANYTHING_SPECIFIC__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FLOOD_AT_CLIENT_HOME_STAFF_PRESENT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FOLLOW_UP_DETAILS__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "FOLLOW_UP__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "GENDER_OF_CALLER__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "GOVT_AGENCY_INVOLVED_AT_THIS_TIME__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HIT_DEVICE_RELATED_TO_EVENT_UNSAFE_COND__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HAS_THE_FACILITY_BEEN_CLOSED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HOSPITALIZED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HOW_INCIDENT_DISCOVERED_REPORTED__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "HOW_PREVENTABLE_WAS_EVENT__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "HOW_MADE_AWARE_OF_THIS_INVESTIGATION__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "HOW_MANY_DAYS_IS_THE_FACILITY_CLOSED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HOW_WAS_CONTACT_INITIATED__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "HOW_WAS_INFORMATION_RETURNED__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "HOW_WAS_THE_HEALTH_HAZARD_DISCOVERED__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "HOW_WAS_THREAT_RECEIVED__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "IM_STATUS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IDENTITY_KNOWN__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INFORMATION_DISCLOSED_DESCRIPTION__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "INFORMATION_DISCLOSED_FORMAT__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "INFORMATION_DISCLOSED_OTHER_FORMAT__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "INFORMATION_DISCLOSED__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "INFORMATION_RECOVERED_DESTROYED__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "INITIAL_PDF_CREATED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INJURY_FROM_THE_ACCIDENT__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "INVOLVED_PARTY_ADDRESS_1__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOLVED_PARTY_ADDRESS_2__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOLVED_PARTY_CITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOLVED_PARTY_EMAIL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOLVED_PARTY_FIRST_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOLVED_PARTY_JOB_POSITION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOLVED_PARTY_LAST_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOLVED_PARTY_PHONE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOLVED_PARTY_POSTAL_CODE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INVOLVED_PARTY_STATE__C"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "IS_THIS_A_PATIENT_RELATED_EVENT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LOCATION_DAMAGES__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCATION_OR_ALLEGED_LOCATION_OF_WEAPON__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MANUFACTURER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MANY_INDIVIDUALS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MEDICAL_TREATMENT_OR_FIRST_AID_PROVIDED__C"
	type = "VARCHAR(50)"
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
	name = "NAME_OF_MEDIA_OUTLET__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NAME_OF_PERSON_CONTACTING_THE_FACILITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NAME_OF_UTILITY_VENDOR_CONTACTED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NON_CLINICAL_EVENT_STATUS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NOTIFY_WHEN_INVESTIGATION_COMPLETE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NUMBER_OF_INDIVIDUALS__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OTHER_HIT_DEVICE_RELATED_TO_EVENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_PROPERTY_MISSING_DAMAGED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_RESPONDER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_TYPE_OF_INVOLVED_PARTY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_TYPE_OF_MEDIA__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_WRITTEN_THREAT_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_ADMIN_BILLING_SYSTEM_COMPONENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_FLOOD_CAUSE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_HEALTH_HAZARD__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_INFESTATION_DETAIL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_INJURED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_INJURY_FROM_EVENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_INTERNAL_DEPARTMENT_NOTIFIED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_NATURAL_DISASTER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_S_INVOLVED_IN_INVESTIGATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_S_INVOLVED_IN_MEDIA_EVENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_S_PERSON_POSSESSING_WEAPON__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_TYPE_OF_EHR_COMPONENT_OF_THE_EHR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_TYPE_OF_INJURY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_TYPE_OF_INVESTIGATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_WEAPON_INVOLVED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PSO_TIME_SUBMISSION__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PATIENT_ACCOUNT_NUMBER__C"
	type = "VARCHAR(50)"
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
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_CITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_CLASS__C"
	type = "VARCHAR(50)"
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
	name = "PATIENT_DISPOSITION__C"
	type = "VARCHAR(50)"
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
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PATIENT_HOME_PHONE__C"
	type = "VARCHAR(15)"
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
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PATIENT_MIDDLE_NAME__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PATIENT_NOTIFIED_OF_EVENT__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PATIENT_PROTECTION_ISSUE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_RECEIVED_IMPROPER_DATA_DOB__C"
	type = "DATE"
	nullable = true
}


column {
	name = "PATIENT_RECEIVED_IMPROPER_DATA_FIRST_NM__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_RECEIVED_IMPROPER_DATA_LAST_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_RECEIVED_IMPROPER_DATA_MRN__C"
	type = "VARCHAR(50)"
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
	name = "PATIENT_VISIT2__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_VISIT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_ZIP_CODE__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PATIENT_INJURED_FROM_ACCIDENT__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PATIENT_S_RACE__C"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "PERSON_MAKING_THREAT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PERSON_S_TAKEN_HOSTAGE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PERSONAL_PROPERTY_MISSING_DAMAGED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIMARY_EMPLOYEE__C"
	type = "VARCHAR(50)"
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
	name = "PRIVACY_CONFIDENTIALITY_CATEGORY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIVACY_OFFICE_FOLLOW_UP__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROPERTY_DAMAGE_DESCRIPTION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PROPERTY_DAMAGE__C"
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
	type = "VARCHAR(50)"
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
	name = "REASON_FOR_INVESTIGATION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "RECIPIENT_HEALTHCARE_PROVIDER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REGULATORY_GOVERNMENT_AGENCY_REPORTED_TO__C"
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
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTABLE_TO_REG_GOVT_AGENCY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTED_TO_THE_COMPLIANCE_OFFICER__C"
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
	name = "REPORTERS_FIRST_LAST_NAME_AND_CONTACT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTING_FOR_SOMEONE_ELSE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REQUEST__C"
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
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REVIWER_COMMENTS__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SECONDARY_EMPLOYEE__C"
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
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERIOUS_REPORTABLE_EVENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVICE_LINE_NCE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SEVERITY_OF_EVENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SPECIFIC_LOCATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SPECIFIC_LOCATION_OF_WEAPON__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SPECIFY_ROOMS_AFFECTED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SPECIFY_OUTSIDE_VENDOR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STAFF_INJURY__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATE_OR_REGULATORY_AGENCY_IES_NOTIFIED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUS__C"
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
	name = "TYPE_OF_BURN__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_EVENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_FLAG__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_INVOLVED_PARTY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_SECURITY_ISSUE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_VISITOR_NON_EMPLOYEE_EVENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_HEALTH_HAZARD__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_INFESTATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_INVESTIGATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_MEDIA_CONTACTING_FACILITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_NATURAL_DISASTER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE_OF_WEAPON_WAS_INVOLVED_OR_MENTIONED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "UTILITY_VENDOR_COMPANY_CONTACTED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VEHICLE_DAMAGES__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VEHICLE_LICENSE_PLATE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VENDOR_S_INVOLVED_IN_VIOLATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WAS_911_CALLED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WAS_A_FIRE_WATCH_INITIATED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WAS_A_THREAT_MADE_TO_USE_THE_WEAPON__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WAS_AN_INTERNAL_DEPARTMENT_NOTIFIED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WAS_ANYONE_INJURED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WAS_INDIVIDUAL_S_APPREHENDED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WAS_THE_FIRE_ALARM_ACTIVATED_MANUALLY__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WAS_THE_FIRE_ALARM_OPERATIONAL__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WAS_THE_FIRE_ALARM_PANEL_RESET__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WAS_THE_FIRE_DEPARTMENT_NOTIFIED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WAS_THE_PATIENT_SENT_TO_THE_ER__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WAS_THE_THREAT_CARRIED_OUT_WEAPON_USED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WERE_ANY_ROOMS_AFFECTED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WERE_FIRE_ALARMS_TRIGGERED_BY_FLOOD__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WERE_THE_DOORS_SUPERVISED_OR_MONITORED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WERE_THE_POLICE_CALLED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WERE_THERE_ANY_ENVRINOMENTAL_DAMAGES__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WERE_THERE_ANY_HUMAN_INJURIES_OR_DEATH__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WERE_THERE_ANY_STRUCTURAL_DAMAGES__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WHAT_AREAS_WERE_CLEANED__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHAT_EVENT_LEAD_TO_MEDIA_INVOLVEMENT__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHAT_HAS_BEEN_DONE_WITH_INFORMATION__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHAT_TYPE_OF_INJURY_WAS_REPORTED__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHAT_WAS_THE_CAUSE_OF_THE_FIRE_SMOKE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHICH_UTILITY_WAS_AFFECTED__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHO_RECEIVED_ACCESSED_INFORMATION__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHO_RESPONDED__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHO_ACTIVATED_THE_FIRE_ALARM__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHO_DID_THE_CLEANING__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHO_DID_THE_VIOLATION_S_AFFECT__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHO_IF_ANY_WERE_INVOLVED__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHO_POSSESSED_THE_WEAPON_MADE_THREAT__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHO_REQUESTING_FOLLOW_UP_AND_WHY__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHO_WAS_INJURED__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHO_WAS_INVOLVED_IMPACTED_BY_THE_EVENT__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHO_WAS_TAKEN_AS_HOSTAGE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHY_DIDN_T_THE_FIRE_ALARM_ACTIVATE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WHY_WAS_FIRE_ALARM_NOT_OPERATIONAL__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WITNESS_CONTACT_INFORMATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WITNESS_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DEPARTMENT_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FACILITY_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IM_DELETE_FLAG__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOLVED_PARTY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OFFICE_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_S_AGE_AT_EVENT__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PRIVACY_CONFIDENTIALITY_DETAIL__C"
	type = "VARCHAR(50)"
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
	name = "EVENT_STATE__C"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "VEHICLE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ALLEGED_THEFT__C"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "COMPLIANCE_CONCERN__C"
	type = "VARCHAR(50)"
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

