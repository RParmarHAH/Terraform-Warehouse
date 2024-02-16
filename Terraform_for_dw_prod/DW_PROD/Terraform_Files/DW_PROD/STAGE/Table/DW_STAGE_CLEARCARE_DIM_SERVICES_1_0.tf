resource "snowflake_table" "DW_STAGE_CLEARCARE_DIM_SERVICES_1_0" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "CLEARCARE_DIM_SERVICES_1_0"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.CLEARCARE_DIM_SERVICES_1_0

    -- Purpose : Business Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SERVICE_KEY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_CODE_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILL_CODE_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "IS_EXPENSE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IS_MULTIPLE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OTHER_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DEFAULT_COST"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "DEFAULT_PAY_UNIT_FLAG"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DEFAULT_BILL_UNIT_FLAG"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CATEGORY_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYROLL_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DEFAULT_REIMBURSMENT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "WC"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SHIFT_PAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OT_PAY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BILL_EXCLUDE_HOLIDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_EXCLUDED_HOLIDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IS_CAT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COMMISSION_RATE"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "BONUS_POINTS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REVENUE_CODE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_FIRST_BIL_LABLE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXPENCE_TYPE_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATED_USER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MODIFIED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MODIFIED_USER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LIST_ITEM_TYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "RPT_GROUP_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OVERRIDE_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "TAX_GROUP_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LEGACY_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LEGACY_BRANCH_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACCT_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "UPLOAD_TELEPHONY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TELEPHONY_TASK_ID"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "INCLUDE_EFT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROJECTED_AVG_BILL_VISIT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROJECTED_AVG_PAY_VISIT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROJECTED_AVG_PAY_HOURLY"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROJECTED_AVG_BILL_HOURLY"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "IS_COPY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IS_WORKING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEDUCTE_ARN"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "LIVE_IN_RPT_HRS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "ACCT_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DISPLAY_ON_CLIENT_PORTAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DISPLAY_ON_CAREGIVER_PORTAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "THERAPY_COUNTING_TYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "MEDICARE_DISCIPLINE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DOC_TYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "IS_MULTIPLE_SERVICE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INSERT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DELETED_FLAG"
	type = "BOOLEAN"
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


column {
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

