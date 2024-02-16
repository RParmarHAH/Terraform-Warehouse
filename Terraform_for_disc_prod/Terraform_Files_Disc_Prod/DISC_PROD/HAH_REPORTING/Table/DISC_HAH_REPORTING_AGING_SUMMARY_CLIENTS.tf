resource "snowflake_table" "DISC_HAH_REPORTING_AGING_SUMMARY_CLIENTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HAH_REPORTING"
	name = "AGING_SUMMARY_CLIENTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HAH_REPORTING.AGING_SUMMARY_CLIENTS

    -- Purpose : Discovery Data Population

    -- Project : HAH_REPORTING

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DFDB"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "CLIENTNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OFFICENUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SUPERVISORCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BILLOFFICE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "AGENT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REGIONCODE"
	type = "VARCHAR(5)"
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

