resource "snowflake_table" "DW_REPORT_ONHOLDCLIENTHISTORY_DATAFLEX" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "ONHOLDCLIENTHISTORY_DATAFLEX"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.ONHOLDCLIENTHISTORY_DATAFLEX

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
	name = "NUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SOURCESYSTEMID"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "DBNAME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ONHOLDSTARTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ONHOLDENDDATE"
	type = "DATE"
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

