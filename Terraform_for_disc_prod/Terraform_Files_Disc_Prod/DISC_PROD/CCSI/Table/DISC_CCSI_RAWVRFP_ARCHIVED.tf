resource "snowflake_table" "DISC_CCSI_RAWVRFP_ARCHIVED" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	name = "RAWVRFP_ARCHIVED"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CCSI.RAWVRFP_ARCHIVED

    -- Purpose : Discovery Data Population

    -- Project : CCSI

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RECORD_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_NAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "SERVICE_TYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HOURS_WORKED"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMPLOYEE_NUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "RECORD_ACCEPTED"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OPERATOR_RESPONSE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROCESSED_BY_WHICH_MODULE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RATE_OF_PAY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "AREA"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CONTRACT_NO"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "AGREEMENT_NO"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PERIOD_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAY_PERIOD_ENDING_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAY_EMPLOYEE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TRANSACTION_TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MILEAGE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EXTRA_HOURS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NON_BILLABLE_HOURS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TRAINING_HOURS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OVERTIME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SUPPLEMENTAL_EARNINGS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VACATION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SICK"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HOME_HOLIDAY_HOURS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_DESK"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMP_DESK"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TRAVEL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PRIVATE_HOME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TRAINING_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED_BY_2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATION_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED_AT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NO_UNITS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UNITS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CITY_OPTED_OUT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "AREA_2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TRAVEL_HOURS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DAY_OF_WEEK"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WEEK_AND_YEAR"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATE_1_ON"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATE_1_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATE_1_AT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATE_2_ON"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATE_2_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATE_2_AT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATE_3_ON"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATE_3_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATE_3_AT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DAY_OF_SERVICE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BILLING_NUMBER"
	type = "VARCHAR(100)"
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

