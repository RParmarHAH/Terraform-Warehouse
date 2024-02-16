resource "snowflake_table" "DISC_AXXESS_AXXESS_PATIENTVISITS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "AXXESS_PATIENTVISITS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.AXXESS_PATIENTVISITS

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
	name = "VISIT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR_CLASS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_PRIMARY_INSURANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CURRENT_PRIMARY_INSURANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "START_OF_CARE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_END_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_DISCHARGE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MRN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_OF_BIRTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_AGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZIP_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISIT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISIT_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISIT_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISIT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISIT_TIME_IN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISIT_TIME_OUT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLINICIAN_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_MISSED_VISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESSLINE_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESSLINE_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_ORDER_FOR_NEXT_EPISODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_VISIT_AUTHORIZATION_REQUIRED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_VISIT_AUTHORIZED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORDER_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORDER_EPISODE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORDER_CERTIFICATION_START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORDER_CERTIFICATION_END_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORDER_MD_SIGNATURE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORDER_PHYSICIAN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORDER_RECEIVED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORDER_RECEIVED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORDER_SENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORDER_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FACT_AR_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISBILLABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_COMPLETED_VISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CASE_MANAGER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLINICIAN_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_FEE_SCHEDULE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYER_ID"
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

