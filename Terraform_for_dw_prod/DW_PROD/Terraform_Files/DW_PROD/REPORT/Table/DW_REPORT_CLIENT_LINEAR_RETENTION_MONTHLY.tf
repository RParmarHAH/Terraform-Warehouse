resource "snowflake_table" "DW_REPORT_CLIENT_LINEAR_RETENTION_MONTHLY" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "CLIENT_LINEAR_RETENTION_MONTHLY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.CLIENT_LINEAR_RETENTION_MONTHLY

    -- Purpose : Business Report Data Population

    -- Project : REPORT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SERVICE_MONTH_NAME"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SERVICE_MONTH"
	type = "DATE"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "30_Days_Active"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "30_Days_Base"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "90_Days_Active"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "90_Days_Base"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "12_Months_Active"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "12_Months_Base"
	type = "BOOLEAN"
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
	name = "ETL_UPDATED_DATE"
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
	type = "NUMBER(1,0)"
	nullable = true
}

}

