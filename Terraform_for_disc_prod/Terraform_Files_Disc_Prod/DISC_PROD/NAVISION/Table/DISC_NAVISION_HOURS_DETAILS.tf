resource "snowflake_table" "DISC_NAVISION_HOURS_DETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "NAVISION"
	name = "HOURS_DETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.NAVISION.HOURS_DETAILS

    -- Purpose : Discovery Data Population

    -- Project : NAVISION

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "TIMESTAMP"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ENTRY_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAYROLL_EMPLOYEE_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "DOCUMENT_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAY_CYCLE_PERIOD_ENDING_DATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "USAGE_DATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EARNINGS_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ACCRUAL_LEDGER_ENTRY_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "HOURS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SOURCE_TYPE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "JOURNAL_BATCH_NAME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "JOURNAL_LINE_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SELECTED"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "START_TIME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "END_TIME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ENTERED_BY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ENTERED_ON"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ENTERED_MANUALLY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "APPROVED___DECLINED_BY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "APPROVED___DECLINED_ON"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "IMPORTED_RECORD"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CANCELED_BY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CANCELED_ON"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "USED_BY_DOCUMENT_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAYROLL_DIMENSION_1_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAYROLL_DIMENSION_2_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAYROLL_DIMENSION_3_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAYROLL_DIMENSION_4_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "JOB_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "JOB_TASK_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CUSTOM_PAYROLL_DIM__1_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CUSTOM_PAYROLL_DIM__2_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CUSTOM_PAYROLL_DIM__3_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CUSTOM_PAYROLL_DIM__4_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "STATE___PROVINCE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "COMPANY_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TIME_IN"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TIME_OUT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TOTAL_AMOUNT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAY_CYCLE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PREVAILING_WAGE_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "POSITION_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "POSITION_DEPARTMENT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "POSITION_CATEGORY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "UNION_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TERMINATION_PAY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TRACKING_ID"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAYROLL_DIMENSION_5_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAYROLL_DIMENSION_6_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAYROLL_DIMENSION_7_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAYROLL_DIMENSION_8_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "G_L_ACCOUNT_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MANUAL_MODIFICATION_BY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MANUAL_MODIFICATION_ON"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAY_CYCLE_SUBTYPE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "WORKERS_COMP__CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "DATE"
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

