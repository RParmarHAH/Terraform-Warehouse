resource "snowflake_table" "DW_PUBLIC_DF_INTAKE_DELETE_2023_08_04" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "DF_INTAKE_DELETE_2023_08_04"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.PUBLIC.DF_INTAKE_DELETE_2023_08_04

    -- Purpose : 

    -- Project : PUBLIC

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "FLG"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "INTAKE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "REPORT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "PRE_AUTH_NUMBER"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CLIENT_BEGIN_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CLIENT_END_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "LATEST_AUTH_BEGIN_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LATEST_AUTH_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REAUTHORIZED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENT_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BILL_RATE"
	type = "NUMBER(37,11)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CASE_MANAGER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HOURS_AUTHORIZED"
	type = "NUMBER(38,12)"
	nullable = true
}


column {
	name = "HOURS_AUTHORIZED_NON_ADJUSTED"
	type = "NUMBER(18,5)"
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

}

