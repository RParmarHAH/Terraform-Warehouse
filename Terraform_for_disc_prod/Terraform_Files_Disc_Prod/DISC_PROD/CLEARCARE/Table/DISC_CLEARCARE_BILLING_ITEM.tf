resource "snowflake_table" "DISC_CLEARCARE_BILLING_ITEM" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "BILLING_ITEM"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.BILLING_ITEM

    -- Purpose : Discovery Data Population

    -- Project : CLEARCARE

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
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "AGENCY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ITEM_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "THE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CARELOG_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILL_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "BILL_PROFILE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "BILL_FINALIZED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILL_QUEUED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILL_EXPORTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PAY_PROFILE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PAY_FINALIZED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_QUEUED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_EXPORTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RAW_DESCRIPTION"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "MILES"
	type = "FLOAT"
	nullable = true
}


column {
	name = "START_TIME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "END_TIME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "TOTAL_TIME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "VISIT_NOTE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "BILL_RATE_METHOD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_RATE_INSTANCE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_RATE_METHOD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_RATE_INSTANCE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SERVICE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "BILL_RATE_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAY_RATE_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "BILL_INVOICED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FROM_CARELOG_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TO_CARELOG_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_PRO_RATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILL_REG_FOR_LIVE_INS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "BILL_LIVE_IN_HOURS_TO_COUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "BILL_OT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "BILL_DOT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "BILL_AUTO_OT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "BILL_AUTO_DOT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "BILL_HOLIDAY_MULTIPLIER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_PRO_RATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_AVERAGE_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PAY_REG_FOR_LIVE_INS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PAY_LIVE_IN_HOURS_TO_COUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PAY_OT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PAY_DOT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PAY_AUTO_OT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PAY_AUTO_OT_IS_WEEK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_AUTO_DOT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PAY_AUTO_DOT_IS_WEEK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_HOLIDAY_MULTIPLIER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CCI_START"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "CCI_END"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "PAY_EXCEL_EXPORTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYMENTS_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "AUTHORIZATION_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "UPDATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "DELETED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "ORIGINATOR_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LAST_UPDATED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DELETED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TRAVEL_TIME_EDITED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHIFT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ORIGINAL_ESTIMATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SHIFT_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "AB_ADJUSTMENT_CARELOG_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OVERTIME_RATE_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IS_BULK_ADDED_ITEM"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SCHEDULED_ITEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "META"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CCI_START_LOCAL"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "CCI_END_LOCAL"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "DATE_DELETED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "FRANCHISOR_ID"
	type = "NUMBER(38,0)"
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

