resource "snowflake_table" "DISC_DEVERO_DEVERO_PATIENT_CHART" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "DEVERO_PATIENT_CHART"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DEVERO.DEVERO_PATIENT_CHART

    -- Purpose : Discovery Data Population

    -- Project : DEVERO

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PATIENT_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHART_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHART_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_MODIFIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHART_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "START_OF_CARE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCHARGE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MR_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AGENCY_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_CODE_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_NAME_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_CODE_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_NAME_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_CODE_3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_NAME_3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_CODE_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_NAME_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_CODE_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_NAME_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_CODE_3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_NAME_3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_CODE_4"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_NAME_4"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_CODE_5"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_NAME_5"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRER_CODE_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRER_NAME_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRER_CODE_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRER_NAME_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRER_CODE_3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRER_NAME_3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FACILITY_CODE_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FACILITY_NAME_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_SOURCE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_SOURCE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHART_REMOVED"
	type = "VARCHAR(16777216)"
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

