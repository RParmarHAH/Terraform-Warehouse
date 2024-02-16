resource "snowflake_table" "DISC_PAYLOCITY_HIST_PAY_STATEMENT_SUMMARY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PAYLOCITY"
	name = "HIST_PAY_STATEMENT_SUMMARY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PAYLOCITY.HIST_PAY_STATEMENT_SUMMARY

    -- Purpose : Discovery Data Population

    -- Project : PAYLOCITY

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "COMPANYID"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "YEAR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "APIRESPONSE"
	type = "VARIANT"
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

