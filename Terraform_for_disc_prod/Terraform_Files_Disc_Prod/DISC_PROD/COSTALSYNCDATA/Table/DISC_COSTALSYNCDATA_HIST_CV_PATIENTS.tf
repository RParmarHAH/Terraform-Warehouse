resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_PATIENTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_PATIENTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_PATIENTS

    -- Purpose : Discovery Data Population

    -- Project : COSTALSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DB"
	type = "VARCHAR(128)"
	nullable = true
}


column {
	name = "DEX_ROW_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENT_NUMBER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "GUARANTOR_NUMBER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "MIDDLE_INITIAL"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "STREET_NAME"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "STATE_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ZIPCODE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY_NUMBER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "BIRTH_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SEX"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "RLNSHIP__CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PROVIDER_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "REFERRING_SOURCE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "CHART_NUMBER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "FIRST_VISIT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PATIENT_SIGN_ON_FILE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "MARITALSTATS_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PATIENT_STATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "RESIDENCY_CODES"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "RACE_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "TOTAL_CHARGE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "TOTAL_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "TOTAL_ADJUSTMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LAST_VISIT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_CHARGE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_PAYMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_ADJUSTMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_STATEMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_CLAIM_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_BILLTO_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CO_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FACILITY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "SEQUENCE_NUMBER"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "TOTAL_CONTRACTUAL"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_CHARGE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_ADJUSTMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD_CHARGE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD_PAYMENTS"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD__ADJUSTMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LOCATION_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "DEPARTMENT__CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "YTD_VISIT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "YTD_VISIT_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BILLTO_STATUS_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "CELL_PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "FAX_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "PRIORITY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "SCHEDULE_COUNT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENT_CANCEL_COUNT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENT_RESCHEDULE_COUNT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENT_MISSED_VISIT_CNT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ENTRY_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

