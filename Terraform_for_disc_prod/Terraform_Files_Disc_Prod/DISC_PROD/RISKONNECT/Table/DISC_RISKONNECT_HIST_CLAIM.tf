resource "snowflake_table" "DISC_RISKONNECT_HIST_CLAIM" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "RISKONNECT"
	name = "HIST_CLAIM"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.RISKONNECT.HIST_CLAIM

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
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "RECORDTYPEID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(25)"
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
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "CONNECTIONSENTID"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "ACCIDENT_ADDRESS_LINE1__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ACCIDENT_ADDRESS_LINE2__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ACCIDENT_CITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCIDENT_COUNTRY__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ACCIDENT_DESCRIPTION__C"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "ACCIDENT_PHOTO__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ACCIDENT_POSTAL_CODE__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "ACCIDENT_STATE__C"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "ACCIDENT_TIME__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "ACTIVITY_ENGAGED_IN__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADDITIONAL_BODY_PARTS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADJUSTER_BRANCH__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADJUSTER_EMAIL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INCIDENT_COUNT__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAUSE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADJUSTER_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ALCOHOL_TEST_COMPLETED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ATTORNEY_REPRESENTATION__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AVERAGE_WEEKLY_WAGE__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BI_DATE_REPORTED__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BI_INCURRED__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BI_PAID__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BI_STATE__C"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "FATALITY_FLAG__C"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "CAUSE_SRC__C"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "SEARCH_CLAIM__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLAIM_KEY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLAIM_REVIEW_STATUS__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLAIM_TYPE_SRC__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLAIM_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLAIMANT_ADDRESS_LINE1__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CLAIMANT_ADDRESS_LINE2__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CLAIMANT_AGE_RANGE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLAIMANT_AGE_SRC__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLAIMANT_AGE__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLAIMANT_CITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLAIMANT_COUNTRY__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLAIMANT_DIED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLAIMANT_DRIVERS_LICENSE_NUMBER__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLAIMANT_DRIVERS_LICENSE_STATE__C"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "CLAIMANT_EMAIL__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CLAIMANT_FIRST_NAME__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CLAIMANT_GENDER__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLAIMANT_HOME_PHONE__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLAIMANT_LAST_NAME__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CLAIMANT_LENGTH_SERVICE__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CLAIMANT_LOOKUP__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CLAIMANT_MARITAL_STATUS_SRC__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "TIME_CANNOT_BE_DETERMINED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLAIMANT_MIDDLE_INITIAL__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CLAIMANT_MINOR__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLAIMANT_MOBILE_PHONE__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CLAIMANT_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLAIMANT_POSTAL_CODE__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CLAIMANT_SSN_LAST_4__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CLAIMANT_SSN__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CLAIMANT_STATE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLAIMANT_WORK_PHONE__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CLIENT_REPORT_LAG_RANGE__C"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "CLIENT_REPORT_LAG__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CONTROVERTED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COVERAGE_MAJOR_DESCRIPTION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COVERAGE_MAJOR_SRC__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "COVERAGE_MAJOR__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "COVERAGE_MINOR_SRC__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "COVERAGE_MINOR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DATE_ADOPTION_PLACEMENT__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_ATTORNEY_DISCLOSURE__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_ATTORNEY_REPRESENTATION__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_CLAIM_RECEIVED_FROM_TPA__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_CLAIM_TRANSMITTED_TO_TPA__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_CLAIMANT_BORN__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_CLAIMANT_DIED__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_CLOSED__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_DATA_LOAD_INSERT__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_DATA_LOAD_UPDATE__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_DENIED__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAUSE_GENERAL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EXPECTED_RTW_DATE__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_HIRED__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_LAST_WORKED__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_MANUFACTURED__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_OPENED__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_REOPENED__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_REPORTED_TO_CLIENT__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_REPORTED_TO_TPA__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_RETURNED_TO_WORK__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NATURE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DATE_SUIT_FILED__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_OF_FIRST_DISABILITY__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_OF_FIRST_MEDICAL_VISIT__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LOCATION_LOOKUP__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DATE_OF_LAST_ACTIVITY__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_OF_LAST_MEDICAL_VISIT__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_OF_LOSS__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_OF_MAXIMUM_MEDICAL_IMPROVEMENT__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NATURE_GENERAL__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DATE_OF_SURGERY__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DAYS_OFF_WORK__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DEFENSE_COUNSEL_LOOKUP__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PART__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PART_GENERAL__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DESCRIPTION_OF_EVENT__C"
	type = "VARCHAR(2500)"
	nullable = true
}


column {
	name = "DETAILED_LEAVE_CODE__C"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "DRIVER_AGE_SRC__C"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "DRIVER_BIRTH_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DRIVER_GENDER__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DRIVER_LOOKUP__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DRIVER_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DRIVERS_AGE__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DRUG_TEST_COMPLETED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "VOID_DT__C"
	type = "DATE"
	nullable = true
}


column {
	name = "EPA_REPORTABLE__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ID__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_JOB_TITLE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMPLOYER_PREMISES__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EMPLOYMENT_STATUS__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EVENT_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EXPENSE_OUTSTANDING__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "FAMILY_MEMBER_DOB__C"
	type = "DATE"
	nullable = true
}


column {
	name = "FAMILY_MEMBER_FIRST_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FAMILY_MEMBER_GENDER__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FAMILY_MEMBER_LAST_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FRIDAY_WORK_HOURS__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "GIFT_CARD_AMOUNT__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "GIFT_CARD__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "GROSS_INCURRED__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "GROSS_PAID__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "HICN__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HEALTHCARE_FACILITY_ADDRESS_LINE_1__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HEALTHCARE_FACILITY_ADDRESS_LINE_2__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HEALTHCARE_FACILITY_CITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HEALTHCARE_FACILITY_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HEALTHCARE_FACILITY_PHONE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HEALTHCARE_FACILITY_POSTAL_CODE__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "HEALTHCARE_FACILITY_STATE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HOSPITALIZED_OVERNIGHT__C"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "ID_PRIOR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SELF_ADMINISTERED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LOSS_DAY__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INDEMNITY_PD_OUTSTANDING__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INJURY_DESCRIPTION__C"
	type = "VARCHAR(2500)"
	nullable = true
}


column {
	name = "DATA_SOURCE_CODE__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INVOLVED_EMPLOYEE_NAME__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "LOAD_INSERT_BATCH_KEY__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "LOAD_UPDATE_BATCH_KEY__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PROPERTY_SRC__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "LEGAL_STATUS_PICKLIST__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LEGAL_STATUS_SRC__C"
	type = "VARCHAR(120)"
	nullable = true
}


column {
	name = "LITIGATION_NAME__C"
	type = "VARCHAR(120)"
	nullable = true
}


column {
	name = "TOTAL_NET_LOSS_RESERVE__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LOCATION_SRC__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOST_DAYS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LOST_TIME_INDICATOR__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LOST_TIME_SRC__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "MSP_INFO_REQUEST_STATUS__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MSP_QUERY_CANDIDATE__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "MSP_QUERY_DATA_STATUS__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "MEDICAL_BI_OUTSTANDING__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MEDICAL_CONDITIONS__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MEDICAL_DIAGNOSIS__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MEDICAL_LEAVE_REASON__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MEDICATIONS_TAKEN__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MONDAY_WORK_HOURS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "NCCI_CLASS_CODE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NCCI_INJURY_CODE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NCCI_LOSS_COVCODE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NCCI_TYPE_CODE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CASE_NO__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NATURE_SRC__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "HAH_EE_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NET_INCURRED__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "NET_OUTSTANDING__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "NET_PAID__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "TOTAL_INCURRED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NUMBER_OF_DEPENDENTS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OSHA_ACCIDENT_LOCATION__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OSHA_CLASSIFICATION__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OSHA_INJURY_TYPE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OSHA_LOG_NUMBER__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OSHA_PRIVACY_CASE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OSHA_RECORDABLE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OSHA_SEVERITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACK_EMAIL_SOURCE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OCCUPATION__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OCCURRENCE_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OFFSITE_MEDICAL_TREATMENT__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OUTSTANDING__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INTAKE_DETAIL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PART_SRC__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NEXT_APPT__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PERCENT_IMPAIRMENT__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PLAINTIFF_COUNSEL_LOOKUP__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POLICY_EFFECTIVE_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "POLICY_EXPIRATION_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "POLICY_LOOKUP__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POLICY_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POLICY_SECTION_LOOKUP__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POLICY_SUBSECTION_LOOKUP__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRODUCT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROPERTY_DAMAGE_DESCRIPTION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROPERTY_DESCRIPTION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "HOW_DID_INCIDENT_OCCUR__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MONTHS_W_CLIENT_ASSAULTS_ONLY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROPERTY_LOOKUP__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PURPOSE_OF_LEAVE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SHARPS__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SHARPS_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NON_RECORDABLE_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RELATIONSHIP_TO_EMPLOYEE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_RECORDABLE_CASE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REPORT_LAG__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "WORK_STATUS_NOTES__C"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "RESTRICTED_DAYS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RESTRICTIONS_PERMANENT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RETURN_TO_WORK_CONDITIONS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SATURDAY_WORK_HOURS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SEND_STATUS_EMAIL__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SEVERITY__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SITE__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SOURCE_GENERAL__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SOURCE_SRC__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SOURCE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATE_CLAIM_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE_FUND_RECOV_INDICATOR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE_OF_EMPLOYMENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE_OF_JURISDICTION__C"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "STATUS_CLOSED_COUNT__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STATUS_COUNT__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STATUS_OPEN_COUNT__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STATUS_REQUESTED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATUS_SRC__C"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "STATUS__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SUBMIT_TO_TPA__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUBROGATION_INDICATOR__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUNDAY_WORK_HOURS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SUPERVISOR_ID__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SUPERVISOR_NOTIFIED__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SURGERY_REQUIRED__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SURGERY_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TPA_CARRIER_ACCOUNT_CODE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HEALTHCARE_PROFESSIONAL__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TPA_CARRIER__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TPA_REPORT_LAG__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TAKEOVER_INDICATOR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TERMINATION_FILE_SENT__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "THIRD_PARTY_INSURANCE_CO__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "THIRD_PARTY_POLICY_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "THURSDAY_WORK_HOURS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADJUSTER_LOOKUP__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MASS_UPDATE_CLAIM_TRIGGER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TREATED_IN_EMERGENCY_ROOM__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TREATMENT_PLAN__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TUESDAY_WORK_HOURS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TWELVE_HOUR_SHIFTS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VEHICLE_DAMAGE_DESCRIPTION__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VEHICLE_FLEET_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VEHICLE_ID_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VEHICLE_LOCATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SHARPS_BRAND__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VEHICLE_MAKE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VEHICLE_MODEL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VEHICLE_PLATE_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VEHICLE_PLATE_STATE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VEHICLE_TOWED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VEHICLE_YEAR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VENDOR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OSHA_TRACKING_STATUS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INTAKE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WORK_RELATED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WORK_RESTRICTIONS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WORK_SCHEDULE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYROLL_ID__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CURRENT_WORK_STATUS__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INCIDENT_CATEGORY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TOTAL_RESTRICTED_DAYS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EXPENSE_INCURRED__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "EXPENSE_PAID__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INDEMNITY_PD_INCURRED__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INDEMNITY_PD_PAID__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "TOTAL_LOST_DAYS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MEDICAL_BI_INCURRED__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MEDICAL_BI_PAID__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "RECOVERY_RECEIVED__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "LOC_LEVEL2__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOC_LEVEL3__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOC_LEVEL4__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOC_LEVEL5__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCATION_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ASSETS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVICE_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "BENCHMARK_RESULTS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RTW_FULL_DUTY_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "RTW_MODIFIED_DUTY_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DURATION_RESULTS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DURATION_STATUS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ANY_PRIOR_VIOLENT_BEHAVIORS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADJUSTER_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIOR_CONDITIONS_INJURIES__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DID_EE_RECEIVE_NOTICE_OF_PPP__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SUPERVISOR__C"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "INTAKE_INCIDENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LATE_REPORT_FLAG__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "LATE_REPORT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LAW_ENFORCEMENT_AGENCY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REQUEST_RECEIVED__C"
	type = "DATE"
	nullable = true
}


column {
	name = "MAXIMUM_DURATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MINIMUM_DURATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OPTIMAL_DURATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IS_EE_OFF_WORK__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIENT_NAME_ASSAULT_ONLY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PREDICTED_DAYS_OF_DISABILITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PREDICTED_STATUS_FLAG__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PREDICTED_STATUS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RTW_STATUS_REQUESTED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INSURANCE_CHECK_ALL_THAT_APPLY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SUPERVISOR_EMAIL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TIME_EMPLOYEE_BEGAN_WORK__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TYPE_OF_LEAVE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IS_LOA_WORK_RELATED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WEATHER_CONDITIONS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RTW_STATUS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DATE_PAPERWORK_SENT_TO_EE__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FORMS_NEEDED_BY__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RTW_DATE__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MANUAL_ENTRY_OF_PTD__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DID_EMPLOYEE_RTW__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FORMS_ACTUALLY_RECEIVED__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INTERMITTENT_LEAVE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AUTO_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CALL_CORVEL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DAYS_OF_WEEK_SCHEDULED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WITNESSES__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WITNESS_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LIT_LOG_NOTES__C"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "TYPE_OF_TREATMENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLAIMANT_MARITAL_STATUS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCATION_TAX_ID__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCATION_PHONE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DATE_REPORTED_TO_BRANCH__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HOSP_ADMIT_DT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMP_FIRST_CONTACT__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DT_FIRST_IND_PMT__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BUREAU_STATE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ATNY_NME_CLMT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ATNY_NME_DFNT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INS_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "THRD_PTY_CONTACT_NME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POST_INJ_WKLY_WAGE__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MTHD_WKLY_WAGE__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ATNY_POSTAL_CLM__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ATNY_STATE_CLMT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ATNY_CITY_CLMT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ATNY_ADDR1_CLMT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ATNY_ADDR2_CLMT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OHIO_FNOL__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FIRST_DAY_OUT__C"
	type = "DATE"
	nullable = true
}


column {
	name = "TRANSMISSION_FILE_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IS_CLAIMANT_OUR_CLIENT__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DATA_LOAD_FLAG__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FCM_TCM_ASSIGNED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOA_BRANCH__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COURT_COUNTY_CASE_NAME__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "IF_NO_WHY__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "IF_OTHER_WHY__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLAIMANT_TYPE__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CONCERNS_REGARDING_INCIDENT__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "MMI__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WAS_A_POLICE_REPORT_FILED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PREFERRED_CASEWORKER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLAIMANT_BIRTHDATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "IS_YOUR_VEHICLE_DAMAGED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WAS_ANYONE_ELSE_IN_THE_VEHICLE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ROUTE_SHIFT_VERIFIED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WAS_THE_CLIENT_INJURED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CORRECTIVE_ACTION_REQUIRED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CORRECTION_ACTION_TYPE_PICK_ALL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DATE_CORRECTION_ACTION_COMPLETED__C"
	type = "DATE"
	nullable = true
}


column {
	name = "CONSISTENT_DISCIPLINE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLAIM_NOTES__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "DATE_FMLA_ENDS__C"
	type = "DATE"
	nullable = true
}


column {
	name = "EE_REPORTING_LAG_TIME__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "RECORDABLE_NOTE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VEHICLE_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PACKET_RECEIVED__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ROUTE_DETAILS__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "JOB_TITLE_ON_DOA__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MATCHING_WC_CLAIM__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INCURRED__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "UPLOAD_PACKET__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SUBRO_COMMENTS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLAIM_ASSIGNED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CORRECTION_ACTION_TIMELY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INCLUDE_IN_LITIGATION_LOG__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "JOB_TITLE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LIABILITY__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATE_FOR_WORKFLOW_LETTERS__C"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "TASKS_COMPLETE__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLOSURE_NOTE__C"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DIARY_NOTES__C"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "VIOLATION_OF_POC_OR_HAH_GUIDELINES__C"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TEMP_L_DTY_BRANCH__C"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CORRESPONDING_CLAIM__C"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "REASON_FOR_CLOSING_THE_CLAIM__C"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CLAIMANT_ADDRESS_LINE_1_1__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLAIMANT_ADDRESS_LINE_2_1__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_CHART__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOA_ADDRESS__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOA__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "UNION_MEMBER__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SANTRAX_ID_NUMBER__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CURRENT_ENROLLMENT__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LANDLORD__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLAIMANT_CITY_1__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLAIMANT_POSTAL_CODE_1__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROTECTED_FMLA__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_EMAIL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MVA_EE_SERVICES_MORE_THAN_1_CLIENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DATE_NCM_ASSIGNED__C"
	type = "DATE"
	nullable = true
}


column {
	name = "CLAIMANT_STATE_1_1__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CASE_HANDLING_DESC__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTED_TO_CARRIER__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REPORTED_TO_COUNSEL__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUSPEND_EMAIL_ALERT_TO_EMPLOYEE__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "UNION_BRANCH__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FMLA_INELIGIBILITY_REASON__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FIELD_OR_ADMIN__C"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "ROUTE_NOTES__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FMLA_EXHAUST_LETTER_SENT__C"
	type = "DATE"
	nullable = true
}


column {
	name = "CLAIM_CLOSED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILLING_PROCESS__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "REGENERATE_ELIGIBLE_LTR_TO_EE__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POPULATES_DATE_FOR_LETTERS__C"
	type = "DATE"
	nullable = true
}


column {
	name = "FMLA_AUTO_CALCULATION__C"
	type = "DATE"
	nullable = true
}


column {
	name = "FULL_12_WKS_FMLA_HOURS_AVAILABLE__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HAH_INCIDENT_STATUS__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CURRENCY_CODE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SERVICE_LINE_MANAGER__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INCIDENT_ADDRESS_LINE_1__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CURRENCY_LOOKUP__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DATE_CLAIMANT_CONTACTED__C"
	type = "DATE"
	nullable = true
}


column {
	name = "EXPENSE_INCURRED_CURR1__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "EXPENSE_INCURRED_CURR2__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "EXPENSE_OUTSTANDING_CURR1__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "EXPENSE_OUTSTANDING_CURR2__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "GROSS_INCURRED_CURR1__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "GROSS_INCURRED_CURR2__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "GROSS_OUTSTANDING_CURR1__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "GROSS_OUTSTANDING_CURR2__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "GROSS_PAID_CURR1__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "GROSS_PAID_CURR2__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INDEMNITY_INCURRED_CURR1__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INDEMNITY_INCURRED_CURR2__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INDEMNITY_OUTSTANDING_CURR1__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INDEMNITY_OUTSTANDING_CURR2__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "LITIGATION_FLAG__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MEDICAL_INCURRED_CURR1__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MEDICAL_INCURRED_CURR2__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MEDICAL_OUTSTANDING_CURR1__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MEDICAL_OUTSTANDING_CURR2__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "NET_INCURRED_CURR1__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "NET_INCURRED_CURR2__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "NET_OUTSTANDING_CURR1__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "NET_OUTSTANDING_CURR2__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "NET_PAID_CURR1__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "NET_PAID_CURR2__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "OCCURRENCE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RESERVE_SET__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXPENSE_PAID_CURR1__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "EXPENSE_PAID_CURR2__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INDEMNITY_PAID_CURR1__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INDEMNITY_PAID_CURR2__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MEDICAL_PAID_CURR1__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MEDICAL_PAID_CURR2__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "RECOVERY_PAID_CURR1__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "RECOVERY_PAID_CURR2__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "RELATED_INCIDENT_DETAIL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INCLUDE_ON_SEVERITY_REPORT__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DATE_LITIGATION_HOLD_REQUESTED__C"
	type = "DATE"
	nullable = true
}


column {
	name = "CONTACT_EMPLOYEE_ID__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FMLA_ELIGIBLE__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FMLA_APPROVED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FMLA_DENIED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TRIGGER_FNOL__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HAH_SYSTEM_ID__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DEFENSE_FILE_CASE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INTERNAL_POSITION_STMT__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ROR_RECEIVED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CARRIER_ACK_LTR_RCD__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CONTACT_VERIFIED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AUTO_INCIDENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_INJURY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INCIDENT_ADDRESS_2__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INCIDENT_ADDRESS__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "INCIDENT_CITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INCIDENT_POSTAL_CODE__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INCIDENT_STATE__C"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "LEAVE_OF_ABSENCE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTED_BY_FIRST_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTED_BY_LAST_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTED_BY_PHONE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "JOB_TITLE_ON_DATE_OF_ABSENCE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_JOB_TITLE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLAIM_ONLY_FOR_DAMAGE_TO_COMPANY_VEHICLE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DOES_EMPLOYEE_SERVICE_MORE_THAN_1_CLIENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DRIVER_INFORMATION_IF_NOT_EMPLOYEE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_CLIENT_VEHICLE_DAMAGE_OUTS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FROM_ADDRESS_IF_INJURED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IS_THE_CLAIMANT_THE_DRIVER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TO_ADDRESS_IF_INJURED__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "WAS_ACCIDENT_THE_OTHER_DRIVER_S_FAULT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DO_YOU_HAVE_INSURANCE_WITH_YOUR_EMPLOYER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DURATION_OF_LEAVE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FMLA_LOA_START_DATE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IM_STATUS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AMBULATORY_EVENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NON_CLINICAL_EVENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENT_VISIT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTER_EMAIL_ADDRESS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTER_FIRST_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTER_LAST_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTER_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTER_PHONE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTER_TITLE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RELATED_AMBULATORY_EVENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RELATED_NON_CLINICAL_EVENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOA_MGMT_REVIEWED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REDUCED_LEAVE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EPL_FNOL__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FIRM_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIRM_ADDRESS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIRM_STATE__C"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "FIRM_PHONE__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "FIRM_CITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COMPLAINT_CHARGE_RECEIVED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ALLEGED_VALUE__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INSURANCE_CARRIER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AUTO_FNOL__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FLEET_MGMT_CLAIM__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COMPLIANCE_CONCERN__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NURSE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NCM_VENDOR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TOTAL_DAYS_NEEDED_TO_REACH_MMI__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NCM_LAG__C"
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

