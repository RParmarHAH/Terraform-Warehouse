resource "snowflake_table" "DW_REPORT_CLIENT_CENSUS_BY_SERVICE_DATE_WEEKLY" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "CLIENT_CENSUS_BY_SERVICE_DATE_WEEKLY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.CLIENT_CENSUS_BY_SERVICE_DATE_WEEKLY

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
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SUPERVISOR_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "REVENUE_CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REVENUE_SUBCATEGORY_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TERMINATED_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "REACTIVATED_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "NEWCLIENT_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "REFERRAL_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "INCLUDE_FOR_EXEC_OPS_CLIENTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INCLUDE_FOR_OPS_PERF_CLIENTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SERVICE_DATE"
	type = "DATE"
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

