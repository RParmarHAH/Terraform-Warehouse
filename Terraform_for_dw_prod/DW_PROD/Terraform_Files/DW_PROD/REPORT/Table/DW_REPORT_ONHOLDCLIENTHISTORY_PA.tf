resource "snowflake_table" "DW_REPORT_ONHOLDCLIENTHISTORY_PA" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "ONHOLDCLIENTHISTORY_PA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.ONHOLDCLIENTHISTORY_PA

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
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "ONHOLDSTARTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ONHOLDENDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}

}

