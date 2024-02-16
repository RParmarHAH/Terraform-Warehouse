resource "snowflake_table" "DISC_AXXESS_AXXESS_CAREPERIODS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "AXXESS_CAREPERIODS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.AXXESS_CAREPERIODS

    -- Purpose : Discovery Data Population

    -- Project : AXXESS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CAREPERIOD_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MRN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_MIDDLE_INITIAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_DOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_AGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_ISMAIN_OFFICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_STATE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_ZIP_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_ZIP_CODE_FOUR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LENGTHOFSTAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_DISCHARGE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_DISCHARGE_REASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_ISNONMEDICAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_STARTOFCARE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREPERIOD_CASEMANAGER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREPERIOD_CASEMANAGER_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREPERIOD_END_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREPERIOD_START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREPERIOD_STARTOFCARE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ADDRESS1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ADDRESS2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_DISCHARGE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ISHOSPITALIZED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ISNONMEDICAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_MEDICAID_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_REFERRAL_SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_ICD10_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_ICD10_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISADMIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISDIRECTADMISSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISDISCHARGED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISREFERRAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_MIDDLE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_ADDRESS1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_ADDRESS2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_NPI"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_STATE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_ZIP_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_MIDDLE_INITIAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_DOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_ISNONMEDICAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_MEDICAID_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_REQUESTED_STARTOFCARE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_SOURCE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_SOURCE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOSPITAL_ADMITDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISHOSPITALIZED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_NDISCHARGE_COMMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISCLIENT_DEPRECATED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ETHNICITIES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_RACES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

