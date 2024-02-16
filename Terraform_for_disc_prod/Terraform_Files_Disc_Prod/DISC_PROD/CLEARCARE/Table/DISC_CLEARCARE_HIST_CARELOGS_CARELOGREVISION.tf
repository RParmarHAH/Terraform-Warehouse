resource "snowflake_table" "DISC_CLEARCARE_HIST_CARELOGS_CARELOGREVISION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "HIST_CARELOGS_CARELOGREVISION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.HIST_CARELOGS_CARELOGREVISION

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
	name = "COMPLETE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATUS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "META"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CCI_SCHEDULED_CLOCK_IN"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "CCI_SCHEDULED_CLOCK_OUT"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "CCI_ACTUAL_CLOCK_IN"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "CCI_ACTUAL_CLOCK_OUT"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "CLOCK_IN"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "CLOCK_OUT"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "CLOCKED_OUT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILL_OFFICIAL_CLOCK_IN"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "BILL_OFFICIAL_CLOCK_OUT"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "PAY_OFFICIAL_CLOCK_IN"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "PAY_OFFICIAL_CLOCK_OUT"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "TOTAL_HOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "NEW_TOTAL_PAY_HOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "NEW_TOTAL_BILL_HOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "SHIFT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CLIENT_ESIG_REQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREGIVER_ESIG_REQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREMANAGER_ESIG_REQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AUTHORIZATION_SPLIT_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "BILL_RATE_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_PRO_RATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILL_RATE_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "ORIGINAL_BILL_RATE_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "BILL_AMOUNT"
	type = "FLOAT"
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
	name = "BILL_FINALIZED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILL_EXPORT_QUEUE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILL_INVOICED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILL_EXPORTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILL_RATE_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "BILL_HOLIDAY_MULTIPLIER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_RATE_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_PRO_RATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_RATE_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "ORIGINAL_PAY_RATE_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PAY_AMOUNT"
	type = "FLOAT"
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
	name = "OVERTIME_RATE_TYPE"
	type = "NUMBER(38,0)"
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
	name = "PAY_FINALIZED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_EXPORT_QUEUE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_EXPORTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_EXCEL_EXPORTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_RATE_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAY_HOLIDAY_MULTIPLIER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IN_FACILITY_PAY_RATES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IN_FACILITY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILL_TIERED"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_TIERED"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYMENTS_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "SPLIT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IS_LAST_CHILD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CHILD_LETTER"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PREVENT_CLOCK_OUT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OLD_CLOCK_IN_METHOD"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "OLD_CLOCK_OUT_METHOD"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CLOCK_IN_METHOD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLOCK_OUT_METHOD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLOCK_IN_POINT"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CLOCK_IN_POINT_ACCURACY"
	type = "FLOAT"
	nullable = true
}


column {
	name = "CLOCK_OUT_POINT"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CLOCK_OUT_POINT_ACCURACY"
	type = "FLOAT"
	nullable = true
}


column {
	name = "BILL_AND_PAY_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HASH"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "IS_COMMUNITY_CARE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLOCK_IN_IP_ADDRESS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CLOCK_OUT_IP_ADDRESS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CARELOG_EDIT_IP_ADDRESS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "BILL_ROUNDING_RULE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_ROUNDING_RULE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CUID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "REVISION_NUM"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AUTHORIZATION_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AUTHORIZATION_SPLIT_ITEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_RATE_OBJ_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CAREGIVER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CARELOGS_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DELETED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LAST_UPDATED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ORIGINATOR_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PARENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PATIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_RATE_OBJ_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PLACE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RATE_CATEGORY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SHIFT_ID"
	type = "NUMBER(38,0)"
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

