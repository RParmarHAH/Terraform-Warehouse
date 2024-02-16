resource "snowflake_table" "DISC_QUALTRICS_QUALTRICS_DATA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "QUALTRICS"
	name = "QUALTRICS_DATA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.QUALTRICS.QUALTRICS_DATA

    -- Purpose : Discovery Data Population

    -- Project : QUALTRICS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CONTACTID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "LANGUAGE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EXTERNALDATAREFERENCE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UNSUBSCRIBED"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATIONDATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ACTIVE_INDICATOR"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "OSHA_CMS_LM_INDICATOR"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "OFFICE_STATE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ASSOCIATE_DISPLAY_FIELD"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LAST_4_DIGITS_OF_SSN"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "DATE_OF_BIRTH"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ROLE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HOME_ADDRESS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HOME_CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HOME_STATE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "WORK_HOURS_INDICATOR"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HOME_ZIP"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "OFFICE_BRANCH"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REGION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYROLL_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ETHNICITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SLT_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HAHID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WFH_IND"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "QUALITY_LEADER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MARKET_LEADER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLINICIAN_IND"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COVID_BONUS_INDICATOR"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FMLA_LOA_IND"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HAH_VACCINATION_STATUS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ED_VT_VAX_UPLOAD_FRONT"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "FULLY_VAX"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ED_VT_STATUS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ED_VT_TERM_DESC"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ED_VT_RETAKE_RESPONSE_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MANAGER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CARD_LINK"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CARD_NAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "VACCINE_CARD_URL"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "MANAGER_EMAIL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VAX_CARD_SOURCE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ED_VT_VACCINE_MANUFACTURER"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "DATECONFIDENCE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "FORMCONFIDENCE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "MANUFACTURERCONFIDENCE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "NAMECONFIDENCE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMAIL_BOUNCED"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "COUNTER"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ED_VT_TEST_DATE_1"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ED_VT_TEST_RESULT_1"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ED_VT_TEST_DATE_2"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ED_VT_TEST_RECORD_DATE_1"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ED_VT_TEST_RECORD_DATE_2"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ED_VT_TEST_RESULT_2"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ED_VT_TEST_UPLOAD_1"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ED_VT_TEST_UPLOAD_2"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ED_VT_TICKET_STATUS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "BRANCH_OFFICE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NAME_OF_CCU_PDD"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PERSONAL_STATEMENT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ACQUISITION_INDICATOR"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "REPORTHYPERLINK"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "REPORTLINK"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "EMAIL_ADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "NAME_OF_CCU"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CARD_NAME_2"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ED_VT_EXEMPTION_UPLOAD"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EXEMPTION_CARD_URL"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "HAH_TESTING_STATUS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "RELIGIOUS_EXEMPT_STATUS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CREATIONDATE2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PRIMARY_PHONE_NUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERIES_COMPLETED"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VAX_MANUF"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OCRERROR"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ROLE2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COMPLETION_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMAIL_ADDRESS2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FV_SECOND_DOSE_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TESTID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FMLA_LOA_RETURN_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PATIENT_1"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PHONE_NUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MED_EXEMPT_STATUS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MEDICAL_EXEMPTION_FORM_NAME"
	type = "VARCHAR(500)"
	nullable = true
}

}

