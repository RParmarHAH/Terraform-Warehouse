resource "snowflake_table" "DW_REPORT_CLIENT_CONVERSION" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "CLIENT_CONVERSION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.CLIENT_CONVERSION

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
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SUPERVISOR_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "REPORT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "COUNT_CLIENTS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "CONVERTED_CLIENTS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "CONVERSION_ALL_TIME"
	type = "NUMBER(24,6)"
	nullable = true
}


column {
	name = "NEW_CLIENTS"
	type = "NUMBER(13,0)"
	nullable = true
}


column {
	name = "LOST_CLIENTS"
	type = "NUMBER(13,0)"
	nullable = true
}


column {
	name = "REFERRED_LAST_MONTH"
	type = "NUMBER(13,0)"
	nullable = true
}


column {
	name = "CONVERTED_LAST_MONTH"
	type = "NUMBER(13,0)"
	nullable = true
}


column {
	name = "CONVERSION_MONTH"
	type = "NUMBER(19,6)"
	nullable = true
}


column {
	name = "CLIENT_NET_CHANGE"
	type = "NUMBER(14,0)"
	nullable = true
}


column {
	name = "NEW_CLIENT"
	type = "NUMBER(1,0)"
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
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}

}

