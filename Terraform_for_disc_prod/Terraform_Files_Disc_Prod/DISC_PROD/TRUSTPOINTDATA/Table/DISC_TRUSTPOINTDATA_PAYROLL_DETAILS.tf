resource "snowflake_table" "DISC_TRUSTPOINTDATA_PAYROLL_DETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "TRUSTPOINTDATA"
	name = "PAYROLL_DETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.TRUSTPOINTDATA.PAYROLL_DETAILS

    -- Purpose : Discovery Data Population

    -- Project : TRUSTPOINTDATA

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
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "COMPANY"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "RECORD_TYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EDT_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYROLL_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "PAY_PERIOD_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAY_PERIOD_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CHECK_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAY_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAY_HOURS"
	type = "NUMBER(12,3)"
	nullable = true
}


column {
	name = "PAY_RATE"
	type = "NUMBER(12,3)"
	nullable = true
}


column {
	name = "PAY_AMOUNT"
	type = "NUMBER(12,3)"
	nullable = true
}


column {
	name = "ADDED_DATE_UTC"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADDED_FILENAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "UPDATED_DATE_UTC"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATED_FILENAME"
	type = "VARCHAR(200)"
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

}

